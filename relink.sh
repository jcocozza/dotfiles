# run this to reset symlinks

# location of the dotfiles repo
REPO_PATH=$(git rev-parse --show-toplevel)

echo "********** relinking dotfiles **********"

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
