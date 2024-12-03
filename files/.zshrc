# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="candy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Activate a python virtual environment assuming you are in the same level as the venv/ folder
alias activate="source venv/bin/activate"
alias grep='grep --color=auto'
alias 'git-tree'='git log --graph --oneline --all'

# vim keybindings in terminal
bindkey -v
export EDITOR=vim
export VISUAL=vim

# commands

# search all branches for text
# if you really want, just call the command then pass to a fuzzy finder to search over all text in all branches (use this at your own risk)
# e.g. `ggrepall | fzf`
ggrepall() {
    git --no-pager branch -a | awk '{print $NF}' | xargs git --no-pager grep -n "$1"
}
