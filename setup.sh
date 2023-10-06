# Location of dotfiles
repo_path=$(dirname "$(readlink -f "$0")")
dotfiles_path="$repo_path/files"

# handle platform dependent installs 
if [[ $(uname -s) == "Darwin" ]]; then
    
    # Install oh-my-zsh - will create a new .zshrc file
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    # Install homebrew 
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
    # Apple Silicon (ARM-based Mac)
    if [[ $(uname -m) == "arm64" ]]; then
        HOMEBREW_PATH="/opt/hombrew"
    # Intel-Based Mac
    else
        HOMEBREW_PATH="/user/local"
    fi 
    
    # expose homebrew so the script can install things 
    eval "$($HOMEBREW_PATH/bin/brew shellenv)"
    
    brew install tmux
    brew tap dracula/install
    brew install --cask dracula-terminal
    echo "NOTE: YOU NEED TO MANUALLY SET THE TERMINAL THEME"
    echo "Terminal > Settings Tab > Import > Dracula.terminal file > Set to default"

    # Add Homebrew to .zshrc
    echo "# Add homebrew to path" >> "$dotfiles_path/.zshrc"
    echo 'eval "$($HOMEBREW_PATH/bin/brew shellenv)"' >> "$dotfiles_path/files/.zshrc"

elif [[ $(uname -s) == "Linux" ]]; then
    sudo apt install zsh
    chsh -s /user/bin/zsh
    
    # Install oh-my-zsh - will create a new .zshrc file
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    apt install tmux
else
    echo "Unsupported system type"
    exit 1
fi

# Add vim folder
mkdir -p ~/.vim/pack/themes/start

# Add dracula to vim
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula

cd ~

# Set simlinks
ln -s "$repo_path/.gitconfig" ~/.gitconfig
ln -s "$repo_path/.vimrc" ~/.vimrc
ln -s "$repo_path/.zshrc" ~/.zshrc

# source files
source ~./gitconfig
source ~./vimrc
source ~./zshrc

