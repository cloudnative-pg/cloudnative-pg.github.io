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

# Set target directory
release_version=${1#v}
DOCDIR=$REPO_ROOT/assets/documentation
TARGETDIR=$DOCDIR/$release_version

# Create a temporary folder in which to clone the CNPG branch
WORKDIR=$(mktemp -d)
mkdir -p $WORKDIR/cnpg

# Clone the branch
git clone --depth 1 --branch release-$release_version git@github.com:cloudnative-pg/cloudnative-pg.git $WORKDIR/cnpg

mkdir -p $TARGETDIR

pushd $WORKDIR/cnpg/docs
docker pull minidocks/mkdocs:latest
docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" \
    -v "$TARGETDIR:/var/cnpg" \
    minidocks/mkdocs:latest \
    mkdocs build -v -d /var/cnpg
popd

rm -rf $WORKDIR

if [ ! -f content/docs/$release_version.md ]
then
  hugo new docs/$release_version.md
  git add content/docs/$release_version.md
fi

# Detect the current version (one with the highest release number)
current_version=$(ls $DOCDIR | sort -n | tail -1)
if [ -d $DOCDIR/current ]
then
    git rm -fr $DOCDIR/current
fi

# Copy the last available doc folder as 'current'
# This is a hack as with GH Pages it is not possible
# to issue server-side redirects
cp -a $DOCDIR/$current_version $DOCDIR/current
git add $DOCDIR/current
git add $TARGETDIR
