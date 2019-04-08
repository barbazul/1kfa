#! /bin/bash

set -e
set -o xtrace

# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell
: "${KFAREPO=/home/sjbrown/work/1kfa}"

PUBLISH=$KFAREPO/publish

BUILDDIR=/tmp/1kfa_guide_build
rm -rf $BUILDDIR
mkdir $BUILDDIR
cp -a $KFAREPO/images $BUILDDIR/images

cd $KFAREPO

SRC_PLAYER=$BUILDDIR/mod_guide_player.md
cp $KFAREPO/mod_guide_player.md $SRC_PLAYER
SRC_GM=$BUILDDIR/mod_guide_gm.md
cp $KFAREPO/mod_guide_gm.md $SRC_GM
SRC_CAMP=$BUILDDIR/mod_guide_campaigns.md
cp $KFAREPO/mod_guide_campaigns.md $SRC_CAMP

DATE=$(date -I)
source $KFAREPO/resolution_cards/version.py # populate VERSION variable

sed --in-place -e "s/DATE/$DATE/" $SRC_PLAYER
sed --in-place -e "s/DATE/$DATE/" $SRC_GM
sed --in-place -e "s/DATE/$DATE/" $SRC_CAMP
sed --in-place -e "s/VERSION/$VERSION/" $SRC_PLAYER
sed --in-place -e "s/VERSION/$VERSION/" $SRC_GM
sed --in-place -e "s/VERSION/$VERSION/" $SRC_CAMP

 #-s                puts the utf-8 header in
 #--self-contained  puts data: URLs in
 #-t html           to HTML
pandoc \
 -s \
 --self-contained \
 --include-in-header=$PUBLISH/tracking.html \
 --toc \
 -t html \
 --css=$PUBLISH/markdown.css \
 --metadata pagetitle="1kFA Player Guide" \
 $SRC_PLAYER -o $BUILDDIR/guide_player.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=$PUBLISH/tracking.html \
 --toc \
 -t html \
 --css=$PUBLISH/markdown.css \
 --metadata pagetitle="1kFA GM Guide" \
 $SRC_GM -o $BUILDDIR/guide_gm.html

pandoc \
 -s \
 --self-contained \
 --include-in-header=$PUBLISH/tracking.html \
 --toc \
 -t html \
 --css=$PUBLISH/markdown.css \
 --metadata pagetitle="1kFA Campaigns Guide" \
 $SRC_CAMP -o $BUILDDIR/guide_campaigns.html

cd $BUILDDIR

#pandoc --reference-doc=$PUBLISH/custom_pandoc_reference.odt $SRC_PLAYER -o /tmp/guide_player.odt
#pandoc --reference-doc=$PUBLISH/custom_pandoc_reference.odt $SRC_GM -o /tmp/guide_gm.odt
#pandoc --reference-doc=$PUBLISH/custom_pandoc_reference.odt $SRC_CAMP -o /tmp/guide_campaigns.odt
#lowriter --headless --convert-to pdf /tmp/guide*.odt

pandoc $SRC_PLAYER --latex-engine=xelatex  -o $BUILDDIR/pl_body.pdf
pandoc $SRC_GM --latex-engine=xelatex  -o $BUILDDIR/gm_body.pdf
pandoc $SRC_CAMP --latex-engine=xelatex  -o $BUILDDIR/ca_body.pdf

pdfjoin --rotateoversize=false \
        $PUBLISH/1kfa_cover_page.pdf \
        $BUILDDIR/pl_body.pdf \
        $PUBLISH/playtest_thankyou.pdf \
        --outfile $BUILDDIR/guide_player.pdf
pdfjoin --rotateoversize=false \
        $PUBLISH/1kfa_cover_page.pdf \
        $BUILDDIR/gm_body.pdf \
        $PUBLISH/playtest_thankyou.pdf \
        --outfile $BUILDDIR/guide_gm.pdf
pdfjoin --rotateoversize=false \
        $PUBLISH/1kfa_cover_page.pdf \
        $BUILDDIR/ca_body.pdf \
        $PUBLISH/playtest_thankyou.pdf \
        --outfile $BUILDDIR/guide_campaigns.pdf


#cd $KFAREPO
# Google Docs template
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt $SRC_PLAYER -o $BUILDDIR/guide_player_gdoc.odt
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt $SRC_GM -o $BUILDDIR/guide_gm_gdoc.odt
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt $SRC_CAMP -o $BUILDDIR/guide_campaigns_gdoc.odt

