export TAG=v1.13.0
rm -rf tmp
mkdir tmp
cd tmp
git clone --depth 1 --branch $TAG git@github.com:cloudnative-pg/cloudnative-pg.git
# TODO: build the API reference
mkdir ../content/docs/$TAG
cp -r cloudnative-pg/docs/src/ ../content/docs/$TAG
mv ../content/docs/$TAG/index.md  ../content/docs/$TAG/_index.md