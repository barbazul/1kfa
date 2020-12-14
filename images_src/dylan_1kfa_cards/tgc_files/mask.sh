#! /bin/bash

# create the mask png
convert -size "825"x"1125" xc:none -draw "roundrectangle 10,10,815,1115,35,35" /tmp/mask.png


mkdir -p /tmp/rounded_corners
echo "Writing $1 to /tmp/rounded_corners ..."
convert $1 -matte /tmp/mask.png -compose DstIn -composite "/tmp/rounded_corners/$1"

BASE="/tmp/rounded_corners/$1"

convert -scale "50%" $BASE "/a/work/1kfa/images/$1"

#convert $BASE -background none -rotate -30 "${BASE%.png}"_rot330.png
#convert $BASE -background none -rotate -20 "${BASE%.png}"_rot340.png
#convert $BASE -background none -rotate -10 "${BASE%.png}"_rot350.png
#convert $BASE -background none -rotate 10 "${BASE%.png}"_rot10.png
#convert $BASE -background none -rotate 20 "${BASE%.png}"_rot20.png
#convert $BASE -background none -rotate 30 "${BASE%.png}"_rot30.png
