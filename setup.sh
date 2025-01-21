#!bin/bash

# The install mode - use "super" if you have sudo access otherwise use "safe"
INSTALL_MODE="$1"

if [[ "${INSTALL_MODE}" == "safe" ]]; then
    echo "installing in safe mode"
elif [[ "${INSTALL_MODE}" == "super" ]]; then
    echo "installing in super mode"
else
    echo "install mode must be set to super or be empty"
    exit 1
fi

# "Flag" for shell setup - either "zsh" or "bash"
SHELL_SETUP="$2"
if [[ "${SHELL_SETUP}" == "zsh" ]]; then
    echo "script will setup zsh"

    # Install oh-my-zsh - will create a new .zshrc file (will be replaced if it is in the files/ dir)
    echo "********** Installing Oh-My-Zsh **********"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
elif [[ "${SHELL_SETUP}" == "bash" ]]; then
    echo "script will setup bash"

    # Install on-my-bash - will create a .bashrc (will be replaced if it is in the files/ dir)
    echo "********** Installing Oh-My-Bash **********"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
else
    echo "shell setup must be either zsh or bash"
    exit 1
fi

# location of the dotfiles repo
REPO_PATH=$(dirname "$(readlink -f "$0")")

# location of dotfiles files path
DOTFILES_PATH="$REPO_PATH/files"

# Create a new branch to keep track of changes to config files on the machine.
# Only update for things that will be applied across all installs
cd $DOTFILES_PATH
BRANCH_NAME="machine/$(hostname)"
git branch $BRANCH_NAME
git checkout $BRANCH_NAME

# convert the gitconfig template to the actual .gitconfig file
cp gitconfig_template .gitconfig
rm gitconfig_template

if [[ $(uname -s) == "Darwin" ]]; then
    echo "********** Running Darwin specific installations **********"
    bash "${REPO_PATH}/setup_darwin.sh" ${INSTALL_MODE}
elif [[ $(uname -s) == "Linux" ]]; then
    echo "********** Running Linux specific installations **********"
    bash "${REPO_PATH}/setup_linux.sh" ${INSTALL_MODE}

    if [[ "${INSTALL_MODE}" == "super" && "${SHELL_SETUP}" == "zsh" ]]; then
        sudo apt -y install zsh
        sudo chsh -s $(which zsh) $(whoami)
    elif [[ "${INSTALL_MODE}" == "safe" && "${SHELL_SETUP}" == "zsh" ]]; then
        echo "[WARNING] super mode required for installing zsh on this machine"
        echo "will continue setup script, but zsh will NOT be installed."
    fi
else
    echo "Unsupported system type"
    exit 1
fi

echo "********** Installing fzf binary **********"
# the install is already executable, so just call it
"${DOTFILES_PATH}/.vim/pack/packages/start/fzf/install"

echo "********** Setting simlinks for dotfiles **********"
cd ~
for file in $(ls -A "${DOTFILES_PATH}"); do
    if [ -e "$file" ]; then
        # remove the existing file version
        mv -f "$file" "old.$file"
    fi
    echo "setting symlink for ${file}"
    ln -s "${DOTFILES_PATH}/$file" "$file"
done

echo "********** ignoring local_shell.sh in future changes **********"
git update-index --skip-worktree "${DOTFILES_PATH}/local_shell.sh"
