#!/bin/bash

# Install script to be run
cd ~
git clone --recurse-submodules https://github.com/jcocozza/dotfiles.git

cd ~/dotfiles
bash setup.sh
