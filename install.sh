#!/bin/bash

INSTALL_MODE="$1"

# Install script to be run
cd ~
git clone --recurse-submodules https://github.com/jcocozza/dotfiles.git

cd ~/dotfiles
bash setup/setup.sh $INSTALL_MODE
