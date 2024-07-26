#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Verify we are working on the root of the repo
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "${REPO_ROOT}"

CNPG_REPOSITORY=https://github.com/cloudnative-pg/cloudnative-pg.git

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
PREVIEW_RELEASE=0

# Create a temporary folder in which to clone the CNPG branch
WORKDIR=$(mktemp -d)
mkdir -p $WORKDIR/cnpg

BRANCH_NAME=release-$release_version
# Use the main branch if we are not targeting a stable version
if ! [[ "${release_version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    BRANCH_NAME="main"
    PREVIEW_RELEASE=1
fi

# Clone the branch
git clone --depth 1 --branch $BRANCH_NAME $CNPG_REPOSITORY $WORKDIR/cnpg

mkdir -p $TARGETDIR

pushd $WORKDIR/cnpg/docs
# Set the version name in the `mkdocs.yml` file
sed -i -s "s/^site_name: CloudNativePG\$/site_name: CloudNativePG v$release_version/" mkdocs.yml

docker pull minidocks/mkdocs:latest
docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" \
    -v "$TARGETDIR:/var/cnpg" \
    minidocks/mkdocs:latest \
    mkdocs build -v -d /var/cnpg
popd

rm -rf $WORKDIR

# Detect the current version (one with the highest release number that is not RC)
latest_version=$(ls $DOCDIR | sort -n | grep -v '\-rc\?' | tail -1)
LATEST_VERSION_LINK_DIR=current

# Preview release
if [ $PREVIEW_RELEASE -eq 1 ]
then
  ROBOTS_FILE="$REPO_ROOT/assets/robots.txt"
  if [ ! -f "$ROBOTS_FILE" ]
  then
    cat > "$ROBOTS_FILE" <<EOF
User-agent: *
EOF
  fi
  cat >> "$ROBOTS_FILE" <<EOF
Disallow: /documentation/$release_version/
EOF
  latest_version=$(ls $DOCDIR | sort -n | grep '\-rc\?' | tail -1)
  LATEST_VERSION_LINK_DIR=preview
else
  # Standard release
  if [ ! -f content/docs/$release_version.md ]
  then
    hugo new docs/$release_version.md
    git add content/docs/$release_version.md
  fi
fi

# This is a hack as with GH Pages it is not possible
# to issue server-side redirects
if [ -d $DOCDIR/$LATEST_VERSION_LINK_DIR ]
then
  git rm -fr $DOCDIR/$LATEST_VERSION_LINK_DIR
fi
# Replace the content of the last available doc folder as 'current' or 'preview'
cp -a $DOCDIR/$latest_version $DOCDIR/$LATEST_VERSION_LINK_DIR
git add $DOCDIR/$LATEST_VERSION_LINK_DIR
git add $TARGETDIR
