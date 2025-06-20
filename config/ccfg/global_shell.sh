#!/bin/bash
#
# global
# this file is sourced by files like .zshrc and .basrc
# it provides commands, environment variables i might want access to

DOTFILES=$(cd $(dirname $(readlink ~/.bashrc))/../.. && pwd)

export EDITOR=vim
export VISUAL=vim

# Activate a python virtual environment assuming you are in the same level as the venv/ folder
alias activate="source venv/bin/activate"
alias grep='grep --color=auto'
alias 'git-tree'='git log --graph --oneline --all'

alias ct='ag -l | ctags -L -'

# use ag to traverse the directory
# this, by default ignores things in gitignore etc
export FZF_DEFAULT_COMMAND="ag -g \"\""

# use default ls coloring
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls="ls -G"  # BSD systems use -G
else
    alias ls="ls --color=auto"
fi

# drop into vim with fzf
alias vimf='vim $(fzf)'
# drop into vim and immediatly open ag
alias vimag='vim -c "Ag"'

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

if [ -f $DOTFILES/config/lcfg/.lbashrc ]; then
    source $DOTFILES/config/lcfg/.lbashrc
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
            pip install flake8 black pyright
        else
            echo "please switch to the virtual environment you'd like to use."
        fi
    fi
}

# cute little command to "compile" python code
# something to the effect of vim -q <(pycompile) will open all "compiler" errors in the quickfix list
pycompile() {
    if command -v pyright > /dev/null 2>&1; then
        pyright --outputjson | jq -r '.generalDiagnostics[] | "\(.file):\(.range.end.line):\(.range.end.character): \(.message | gsub("\n"; " "))"'
    fi
    if command -v flake8 > /dev/null 2>&1; then
        flake8 **/*.py
    fi
}
