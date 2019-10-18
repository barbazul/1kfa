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
cp $PUBLISH/1kfa_cover_page.pdf $BUILDDIR/
cp $PUBLISH/playtest_thankyou.pdf $BUILDDIR/

mkdir -p ~/.fonts/
cp $KFAREPO/fonts/*.[ot]tf ~/.fonts/

cd $KFAREPO

SRC_PLAYER=$BUILDDIR/mod_guide_player.md
cp $KFAREPO/mod_guide_player.md $SRC_PLAYER
SRC_GM=$BUILDDIR/mod_guide_gm.md
cp $KFAREPO/mod_guide_gm.md $SRC_GM

DATE=$(date -I)
source $KFAREPO/resolution_cards/version.py # populate VERSION variable

sed --in-place -e "s/DATE/$DATE/" $SRC_PLAYER
sed --in-place -e "s/DATE/$DATE/" $SRC_GM
sed --in-place -e "s/VERSION/$VERSION/" $SRC_PLAYER
sed --in-place -e "s/VERSION/$VERSION/" $SRC_GM

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
 $SRC_GM -o $BUILDDIR/guide_gm.html

cd $BUILDDIR

#pandoc --reference-doc=$PUBLISH/custom_pandoc_reference.odt $SRC_PLAYER -o /tmp/guide_player.odt
#pandoc --reference-doc=$PUBLISH/custom_pandoc_reference.odt $SRC_GM -o /tmp/guide_gm.odt
#lowriter --headless --convert-to pdf /tmp/guide*.odt

cat $PUBLISH/frontmatter_player.yml $SRC_PLAYER > $BUILDDIR/player_pdf_src.md
pandoc \
  $BUILDDIR/player_pdf_src.md --latex-engine=xelatex \
  -o $BUILDDIR/guide_player.pdf

cat $PUBLISH/frontmatter_player_phone.yml $SRC_PLAYER > $BUILDDIR/player_phone_pdf_src.md
pandoc \
  $BUILDDIR/player_phone_pdf_src.md --latex-engine=xelatex \
  -o $BUILDDIR/guide_player_phone.pdf

cat $PUBLISH/frontmatter_gm.yml $SRC_GM > $BUILDDIR/gm_pdf_src.md
pandoc \
  $BUILDDIR/gm_pdf_src.md --latex-engine=xelatex \
  -o $BUILDDIR/guide_gm.pdf

cat $PUBLISH/frontmatter_gm_phone.yml $SRC_GM > $BUILDDIR/gm_phone_pdf_src.md
pandoc \
  $BUILDDIR/gm_phone_pdf_src.md --latex-engine=xelatex \
  -o $BUILDDIR/guide_gm_phone.pdf

# Don't need this because I figured out how to add it with .md frontmatter
#pdfjoin --rotateoversize=false \
#        $PUBLISH/1kfa_cover_page.pdf \
#        $BUILDDIR/pl_body.pdf \
#        $PUBLISH/playtest_thankyou.pdf \
#        --outfile $BUILDDIR/guide_player.pdf


#cd $KFAREPO
# Google Docs template
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt $SRC_PLAYER -o $BUILDDIR/guide_player_gdoc.odt
#pandoc --reference-odt=custom_pandoc_gdoc_reference.odt $SRC_GM -o $BUILDDIR/guide_gm_gdoc.odt

