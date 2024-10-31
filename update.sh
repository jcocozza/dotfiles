# this will update
#
# The logic for my dotfiles is different then the typical git branching structure.
# Branch "main" is consider the base. It contains things that are standard across ALL repos

# This is set on install
# it *should* be checked out already, but just in case we do this
BRANCH_NAME="machine/$(hostname)"
echo "running update for: $BRANCH_NAME"

git checkout $BRANCH_NAME
git fetch origin

echo "attempting pull and rebase from main"
echo "if conflicts occur:"
echo "  1. resolve them"
echo "  2. continue with git rebase --continue"
git pull --rebase origin main
