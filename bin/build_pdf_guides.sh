#! /bin/bash

set -e
set -o xtrace

# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell
: "${KFAREPO=/home/sjbrown/work/1kfa}"

PUBLISH=$KFAREPO/publish

BUILDDIR=/tmp/1kfa_guide_build
rm -rf $BUILDDIR
mkdir $BUILDDIR

cd $KFAREPO

source $KFAREPO/resolution_cards/version.py

cp publish/markdown.css /tmp/markdown.css

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
 --metadata pagetitle="1kFA Player Guide" \
 mod_guide_player.md -o $BUILDDIR/guide_player.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=publish/tracking.html \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 --metadata pagetitle="1kFA GM Guide" \
 mod_guide_gm.md -o $BUILDDIR/guide_gm.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=publish/tracking.html \
 --toc \
 -t html \
 --css=/tmp/markdown.css \
 --metadata pagetitle="1kFA Campaigns Guide" \
 mod_guide_campaigns.md -o $BUILDDIR/guide_campaigns.html

#pandoc --reference-doc=custom_pandoc_reference.odt mod_guide_player.md -o /tmp/guide_player.odt
#pandoc --reference-doc=custom_pandoc_reference.odt mod_guide_gm.md -o /tmp/guide_gm.odt
#pandoc --reference-doc=custom_pandoc_reference.odt mod_guide_campaigns.md -o /tmp/guide_campaigns.odt
#cd $BUILDDIR
#lowriter --headless --convert-to pdf /tmp/guide*.odt

pandoc mod_guide_player.md --latex-engine=xelatex  -o $BUILDDIR/guide_player.pdf
pandoc mod_guide_gm.md --latex-engine=xelatex  -o $BUILDDIR/guide_gm.pdf
pandoc mod_guide_campaigns.md --latex-engine=xelatex  -o $BUILDDIR/guide_campaigns.pdf

cd $BUILDDIR
pdfjoin --rotateoversize=false "$PUBLISH/1kfa_cover_page.pdf" guide_player.pdf "$PUBLISH/playtest_thankyou.pdf" --outfile x_guide_player.pdf
pdfjoin --rotateoversize=false "$PUBLISH/1kfa_cover_page.pdf" guide_gm.pdf "$PUBLISH/playtest_thankyou.pdf" --outfile x_guide_gm.pdf
pdfjoin --rotateoversize=false "$PUBLISH/1kfa_cover_page.pdf" guide_campaigns.pdf "$PUBLISH/playtest_thankyou.pdf" --outfile x_guide_campaigns.pdf

mv x_guide_player.pdf guide_player.pdf
mv x_guide_gm.pdf guide_gm.pdf
mv x_guide_campaigns.pdf guide_campaigns.pdf




#cd $KFAREPO
# Google Docs template
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_player.md -o $BUILDDIR/guide_player_gdoc.odt
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_gm.md -o $BUILDDIR/guide_gm_gdoc.odt
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt mod_guide_campaigns.md -o $BUILDDIR/guide_campaigns_gdoc.odt

