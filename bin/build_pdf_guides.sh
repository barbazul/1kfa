#! /bin/bash

# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell
: "${DECKAHEDRON_SITE_LOC=/home/sjbrown/work/deckahedron_site/playtest_files}"
: "${KFAREPO=/home/sjbrown/work/1kfa}"

echo "DSITE"
echo $DECKAHEDRON_SITE_LOC

cd $KFAREPO

cp ./markdown.css /tmp/markdown.css

rm -rf /tmp/1kfa_playtest
mkdir /tmp/1kfa_playtest

 #-s                puts the utf-8 header in
 #--self-contained  puts data: URLs in
 #-t html           to HTML
pandoc \
 -s \
 --self-contained \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_player.md -o /tmp/1kfa_playtest/guide_player.html

pandoc \
 -s \
 --self-contained \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_gm.md -o /tmp/1kfa_playtest/guide_gm.html

pandoc \
 -s \
 --self-contained \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_campaigns.md -o /tmp/1kfa_playtest/guide_campaigns.html

cp /tmp/1kfa_playtest/*.html $DECKAHEDRON_SITE_LOC/

pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_player.md -o /tmp/guide_player.odt
pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_gm.md -o /tmp/guide_gm.odt
pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_campaigns.md -o /tmp/guide_campaigns.odt

rm -rf /tmp/1kfadist
mkdir /tmp/1kfadist
cd /tmp/1kfadist

lowriter --headless --convert-to pdf /tmp/guide*.odt

pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_player.pdf cat output x_guide_player.pdf
pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_gm.pdf cat output x_guide_gm.pdf
pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_campaigns.pdf cat output x_guide_campaigns.pdf

mv x_guide_player.pdf guide_player.pdf
mv x_guide_gm.pdf guide_gm.pdf
mv x_guide_campaigns.pdf guide_campaigns.pdf


cp *pdf /tmp/1kfa_playtest/
cp *pdf $DECKAHEDRON_SITE_LOC

cd /tmp/
#zip -r 1kfa_playtest 1kfa_playtest
tar -cvf 1kfa_playtest.tar 1kfa_playtest/
gzip 1kfa_playtest.tar
mv 1kfa_playtest.tar.gz $DECKAHEDRON_SITE_LOC/1kfa_playtest.tgz


cd $KFAREPO
# Google Docs template
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_player.md -o /tmp/1kfadist/guide_player_gdoc.odt
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_gm.md -o /tmp/1kfadist/guide_gm_gdoc.odt
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_campaigns.md -o /tmp/1kfadist/guide_campaigns_gdoc.odt

