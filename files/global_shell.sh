#!/bin/bash
#
# global 
# this file is sourced by files like .zshrc and .basrc
# it provides commands, environment variables i might want access to

export EDITOR=vim
export VISUAL=vim

# Activate a python virtual environment assuming you are in the same level as the venv/ folder
alias activate="source venv/bin/activate"
alias grep='grep --color=auto'
alias 'git-tree'='git log --graph --oneline --all'

# git grep all (ggrepall)
# search all git branches for text
# if you really want, just call the command then pass to a fuzzy finder to search over all text in all branches (use this at your own risk)
# e.g. `ggrepall | fzf`
ggrepall() {
    git --no-pager branch -a | awk '{print $NF}' | xargs git --no-pager grep -n "$1"
}
