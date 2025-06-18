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

# location of the dotfiles repo
REPO_PATH=$(git rev-parse --show-toplevel)

# Create a new branch to keep track of changes to config files on the machine.
# Only update for things that will be applied across all installs
cd $REPO_PATH
BRANCH_NAME="machine/$(hostname)"
git branch $BRANCH_NAME
git checkout $BRANCH_NAME

if [[ $(uname -s) == "Darwin" ]]; then
    echo "********** Running Darwin specific installations **********"
    bash "${REPO_PATH}/setup/setup_darwin.sh" ${INSTALL_MODE}
elif [[ $(uname -s) == "Linux" ]]; then
    echo "********** Running Linux specific installations **********"
    bash "${REPO_PATH}/setup/setup_linux.sh" ${INSTALL_MODE}
else
    echo "Unsupported system type"
    exit 1
fi


echo "********** Setting simlinks for dotfiles **********"
# location of dotfiles that need to be symlinked to home dir
CONFIGS="$REPO_PATH/config/cfg"
cd ~
for file in $(ls -A "${CONFIGS}"); do
    if [ -e "$file" ]; then
        # remove the existing file version
        mv -f "$file" "old.$file"
    fi
    echo "setting symlink for ${file}"
    ln -s "${CONFIGS}/$file" "$file"
done

echo "********** Installing fzf binary **********"
# the install is already executable, so just call it
"${CONFIGS}/.vim/pack/packages/start/fzf/install"

echo "********** ignoring future changes in local files **********"
LCONFIGS="$REPO_PATH/config/lcfg"
cd $LCONFIGS
for file in $(ls -A "${LCONFIGS}"); do
    git update-index --skip-worktree "${LCONFIGS}/$file"
done
