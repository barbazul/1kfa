#! /bin/bash

echo "Publish Web"

source $KFAREPO/resolution_cards/version.py
cd /tmp/
rm -rf deckahedron_site
git clone https://github.com/sjbrown/deckahedron_site.git
mkdir -p deckahedron_site/dist/$VERSION
cd deckahedron_site/dist/$VERSION
cp /tmp/*tar.gz ./
rm -rf ./cards_v$VERSION
cp -a /tmp/cards_v$VERSION ./cards_v$VERSION
find cards_v$VERSION |grep svg |xargs rm

git add .
git config credential.helper 'cache --timeout=120'
git config user.email "sjbrown@geeky.net"
git config user.name "Circle CI Deployment Bot"
git commit --allow-empty -m "Automatic Circle CI build $CIRCLE_BUILD_URL"
git push -q https://${GITHUB_TOKEN}@github.com/sjbrown/deckahedron_site.git master

