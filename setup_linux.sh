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
fi
