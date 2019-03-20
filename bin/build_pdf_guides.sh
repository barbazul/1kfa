#! /bin/bash

# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell
: "${KFAREPO=/home/sjbrown/work/1kfa}"

cd $KFAREPO

cp publish/markdown.css /tmp/markdown.css

rm -rf /tmp/1kfa_playtest
mkdir /tmp/1kfa_playtest

 #-s                puts the utf-8 header in
 #--self-contained  puts data: URLs in
 #-t html           to HTML
pandoc \
 -s \
 --self-contained \
 --include-in-header=publish/tracking.html \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_player.md -o /tmp/1kfa_playtest/guide_player.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=publish/tracking.html \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_gm.md -o /tmp/1kfa_playtest/guide_gm.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=publish/tracking.html \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 mod_guide_campaigns.md -o /tmp/1kfa_playtest/guide_campaigns.html


pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_player.md -o /tmp/guide_player.odt
pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_gm.md -o /tmp/guide_gm.odt
pandoc --reference-odt=custom_pandoc_reference.odt mod_guide_campaigns.md -o /tmp/guide_campaigns.odt

rm -rf /tmp/1kfa_build
mkdir /tmp/1kfa_build
cd /tmp/1kfa_build

lowriter --headless --convert-to pdf /tmp/guide*.odt

pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_player.pdf cat output x_guide_player.pdf
pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_gm.pdf cat output x_guide_gm.pdf
pdftk "$KFAREPO/1kfa_cover_page.pdf" guide_campaigns.pdf cat output x_guide_campaigns.pdf

mv x_guide_player.pdf guide_player.pdf
mv x_guide_gm.pdf guide_gm.pdf
mv x_guide_campaigns.pdf guide_campaigns.pdf


cp *pdf /tmp/1kfa_playtest/

cp /tmp/print_and_play*pdf /tmp/1kfa_playtest/

cd /tmp/
#zip -r 1kfa_playtest 1kfa_playtest
tar -cvf 1kfa_playtest.tar 1kfa_playtest/
gzip 1kfa_playtest.tar


cd $KFAREPO
# Google Docs template
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_player.md -o /tmp/1kfa_build/guide_player_gdoc.odt
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_gm.md -o /tmp/1kfa_build/guide_gm_gdoc.odt
pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_campaigns.md -o /tmp/1kfa_build/guide_campaigns_gdoc.odt

