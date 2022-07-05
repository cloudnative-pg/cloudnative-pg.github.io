#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Verify we are working on the root of the repo
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "${REPO_ROOT}"

# Require a version to be specified
if [ "$#" -ne 1 ]; then
    echo "Usage: hack/import_docs.sh release-version"
    echo ""
    echo "e.g. hack/import_docs.sh 1.15"
    exit 1
fi

release_version=${1#v}

# Create a temporary folder in which to clone the CNPG branch
WORKDIR=$(mktemp -d)
mkdir -p $WORKDIR/cnpg

# Clone the branch
git clone --depth 1 --branch release-$release_version git@github.com:cloudnative-pg/cloudnative-pg.git $WORKDIR/cnpg

DOCDIR=$REPO_ROOT/assets/documentation/$release_version
mkdir -p $DOCDIR

cp -r $WORKDIR/cnpg/docs/src/* $DOCDIR
mv $DOCDIR/index.md  $DOCDIR/_index.md

rm -rf $WORKDIR

hugo new docs/$release_version.md
