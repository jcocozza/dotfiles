#!/bin/bash
#
# The setup script for linux

if [[ $(uname -s) != "Linux" ]]; then
    echo "this script is for Linux platforms"
    exit 1
fi

# The install mode
INSTALL_MODE="$1"
if [[ -z "${INSTALL_MODE}" ]]; then
    echo "install mode required"
    exit 1
fi

# Handle installs that require sudo
if [[ "${INSTALL_MODE}" == "super" ]]; then
    sudo apt install silversearcher-ag
else
    echo "********** installing the silver searcher **********"
    git clone https://github.com/ggreer/the_silver_searcher.git
    cd the_silver_searcher
    ./build.sh # this will create the `ag` binary in the_silver_searcher directory
    mv ag "$HOME/.local/bin"
    cd ..
    rm -rf the_silver_searcher # clean up
fi

echo "********** installing universal ctags **********"
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
mv ctags "$HOME/.local/bin"
cd ..
rm -rf ctags
