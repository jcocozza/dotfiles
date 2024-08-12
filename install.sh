#!/bin/bash

INSTALL_MODE="$1"
SHELL_SETUP="$2"

# Install script to be run
cd ~
git clone --recurse-submodules https://github.com/jcocozza/dotfiles.git

cd ~/dotfiles
bash setup.sh $INSTALL_MODE $SHELL_SETUP
