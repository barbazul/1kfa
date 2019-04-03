#! /bin/bash

echo "Install Deps"

set -e
if [ $DEBUG ]; then
  set -x
fi

sudo apt-get install -y texlive-extra-utils
sudo apt-get install -y inkscape
# THIS DOESNT WORK: sudo apt-get install -y python-lxml
sudo pip install lxml

