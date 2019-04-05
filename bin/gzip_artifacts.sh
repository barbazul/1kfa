#! /bin/bash

set -e
if [ $DEBUG ]; then
  set -x
fi

# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell
: "${KFAREPO=/home/sjbrown/work/1kfa}"

source $KFAREPO/resolution_cards/version.py

cd /tmp/

rm -f 1kfa_playtest.tar.gz
rm -f 1kfa_playtest.tar
tar -c --exclude=*.svg -f 1kfa_playtest.tar 1kfa_playtest/
gzip 1kfa_playtest.tar

rm -f cards_v$VERSION.tar.gz
rm -f cards_v$VERSION.tar
tar -c --exclude=*.svg -f cards_v$VERSION.tar cards_v$VERSION
gzip cards_v$VERSION.tar

