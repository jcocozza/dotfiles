# this will update
#
# The logic for my dotfiles is different then the typical git branching structure.
# Branch "main" is consider the base. It contains things that are standard across ALL repos

# This is set on install
# it *should* be checked out already, but just in case we do this
BRANCH_NAME="machine/$(hostname)"
echo "running update for: $BRANCH_NAME"

# location of the dotfiles repo
REPO_PATH=$(git rev-parse --show-toplevel)

git checkout $BRANCH_NAME
git fetch origin

echo "attempting pull and rebase from main"
echo "if conflicts occur:"
echo "  1. resolve them"
echo "  2. continue with git rebase --continue"
git pull --rebase origin main

echo "updating submodules..."
# if there are any new submodules we need to initialze them
git submodule init
# update submodules
git submodule update

echo "********** updating simlinks for dotfiles **********"
cd ~
CONFIGS="$REPO_PATH/config/cfg"
echo "dotfiles are located in: ${CONFIGS}"
for file in $(ls -A "${CONFIGS}"); do
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        # remove the existing file version
        mv -f "$file" "old.$file"
    fi
    if [ -L $file ]; then
        continue
    fi
    echo "setting symlink for ${file}"
    ln -s "${CONFIGS}/$file" "$file"
done
