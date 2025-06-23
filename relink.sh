# run this to reset symlinks

# location of the dotfiles repo
REPO_PATH=$(git rev-parse --show-toplevel)

echo "********** relinking dotfiles **********"

CONFIGS="$REPO_PATH/config/cfg"
echo "dotfiles are located in: ${CONFIGS}"
for file in $(ls -A "${CONFIGS}"); do
    if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        # remove the existing file version
        mv -f "$HOME/$file" "$HOME/old.$file"
    fi
    if [ -L $HOME/$file ]; then
        continue
    fi
    echo "setting symlink for ${file}"
    ln -s "${CONFIGS}/$file" "$HOME/$file"
done
