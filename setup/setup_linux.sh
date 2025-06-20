#!/bin/bash
#
# The setup script for linux

if [[ $(uname -s) != "Linux" ]]; then
    echo "this script is for Linux platforms"
    exit 1
fi

# The install mode
INSTALL_MODE = "$1"
if [[ -z "${INSTALL_MODE}" ]]; then
    echo "install mode required"
    exit 1
fi

# Handle installs that require sudo
if [[ "${INSTALL_MODE}" == "super" ]]; then
    sudo apt install silversearcher-ag
else
    git clone https://github.com/ggreer/the_silver_searcher.git
    cd the_silver_searcher
    ./build.sh # this will create the `ag` binary in the_silver_searcher directory
    mkdir -p ~/.local/bin
    mv ag ~/.local/bin
    cd ..
    rm -rf the_silver_searcher # clean up
fi
