#! /bin/bash

echo "Install Deps"

set -e
if [ $DEBUG ]; then
  set -x
fi

sudo apt-get install -y texlive-extra-utils
sudo apt-get install -y inkscape

