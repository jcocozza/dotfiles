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

# drop into vim with fzf
alias vimf='vim $(fzf)'

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

if [ -f ~/dotfiles/files/local_shell.sh ]; then
    source ~/dotfiles/files/local_shell.sh
fi

# git grep all (ggrepall)
# search all git branches for text
# if you really want, just call the command then pass to a fuzzy finder to search over all text in all branches (use this at your own risk)
# e.g. `ggrepall | fzf`
ggrepall() {
    git --no-pager branch -a | awk '{print $NF}' | xargs git --no-pager grep -n "$1"
}


# a command that will install the tools that makes vim + python nice based on my setup
python_venv_setup() {
    ask_yes_no() {
        echo "virtual environment path is: $VIRTUAL_ENV"
        echo -n "is this the virtual environment you'd like to install packages in? (y/n): "
        read choice
        # Check the input
        case "$choice" in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Invalid input, please enter y or n."; ask_yes_no;; # Reask if input is invalid
      esac
    }

    if [ -z "$VIRTUAL_ENV" ]; then
        echo "no python virtual environment is active. please activate."
    else
        ask_yes_no
        if [ $? -eq 0 ]; then
            echo "installing to $VIRTUAL_ENV..."
            pip install flake8 mypy black python-lsp-server
        else
            echo "please switch to the virtual environment you'd like to use."
        fi
    fi
}
