#!/bin/bash

# Location of dotfiles
repo_path=$(dirname "$(readlink -f "$0")")
dotfiles_path="$repo_path/files"
# Create a new branch to keep track of changes to config files on the machine. This way the main repo can stay clean
# And only get updated for things that will be applied across installs
cd $dotfiles_path
branch_name="machine/$(hostname)"
git branch $branch_name
git checkout $branch_name

# handle platform dependent installs
if [[ $(uname -s) == "Darwin" ]]; then

    # Install oh-my-zsh - will create a new .zshrc file
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Install homebrew
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

    brew install tmux
    brew install the_silver_searcher
    brew install htop
    brew tap dracula/install
    brew install --cask dracula-terminal
    echo "NOTE: YOU NEED TO MANUALLY SET THE TERMINAL THEME"
    echo "Terminal > Settings Tab > Import > Dracula.terminal file > Set to default"

    # Add Homebrew to .zshrc
    echo "# Add homebrew to path" >> "$dotfiles_path/.zshrc"
    echo 'eval "$($HOMEBREW_PATH/bin/brew shellenv)"' >> "$dotfiles_path/.zshrc"

elif [[ $(uname -s) == "Linux" ]]; then
    sudo apt -y install zsh
    sudo chsh -s $(which zsh) $(whoami)

    # Install oh-my-zsh - will create a new .zshrc file
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    sudo apt install tmux
    sudo apt install silversearcher-ag
else
    echo "Unsupported system type"
    exit 1
fi

# Don't need to do the following anymore becuase everything is included in the repo
# Add vim folder
# mkdir -p ~/.vim/pack/themes/start
# Add dracula to vim
# cd ~/.vim/pack/themes/start
# git clone https://github.com/dracula/vim.git dracula
cd ~
# remove old versions
# rm ~/.gitconfig
# rm ~/.vimrc
# rm ~/.zshrc

for file in $(ls -A "$dotfiles_path"); do
    if [ -e "$file" ]; then
        # remove the existing file version
        mv -f "$file" "old.$file"
    fi
    ln -s "$dotfiles_path/$file" "$file"
done

# Don't need these any more (handled in the for loop)
# Set simlinks
# ln -s "$dotfiles_path/.gitconfig" ~/.gitconfig
# ln -s "$dotfiles_path/.vimrc" ~/.vimrc
# ln -s "$dotfiles_path/.zshrc" ~/.zshrc

# reboot
sudo reboot
