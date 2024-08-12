#!/bin/bash
#
# The setup script for MacOS

if [[ $(uname -s) == "Darwin" ]]; then
    echo "this script is for MacOS/Darwin platforms"
    exit 1
fi

# Install homebrew
echo "********** Installing Homebrew **********"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon (ARM-based Mac)
if [[ $(uname -m) == "arm64" ]]; then
    HOMEBREW_PATH="/opt/homebrew"
# Intel-Based Mac
else
    HOMEBREW_PATH="/usr/local"
fi

# expose homebrew so the script can install things
eval "$($HOMEBREW_PATH/bin/brew shellenv)"
echo "********** Homebrew Installed **********"

echo "********** Installing Tmux **********"
brew install tmux

echo "********** Installing The Silver Searcher **********"
brew install the_silver_searcher

echo "********** Installing Htop **********"
brew install htop

echo "********** Installing Dracula Theme **********"
brew tap dracula/install
brew install --cask dracula-terminal
echo "NOTE: YOU NEED TO MANUALLY SET THE TERMINAL THEME"
echo "Terminal > Settings Tab > Import > Dracula.terminal file > Set to default"
