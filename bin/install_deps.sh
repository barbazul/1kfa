#! /bin/bash

echo "Install Deps"

set -e
if [ $DEBUG ]; then
  set -x
fi

sudo apt-get install -y texlive-extra-utils \
  inkscape \
  pandoc=1.19.2.4 \
  texlive-full \
  wget

# THIS DOESNT WORK: sudo apt-get install -y python-lxml
sudo pip install lxml

mkdir -p $HOME/.fonts
wget -O $HOME/.fonts/OptimusPrinceps.ttf https://raw.githubusercontent.com/sjbrown/1kfa/master/publish/OptimusPrinceps.ttf
