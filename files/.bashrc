# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export TERM='xterm-256color'

# vi keybinding in terminal
set -o vi

# source the global stuff
if [ -f ~/dotfiles/files/global_shell.sh ]; then
  source ~/dotfiles/files/global_shell.sh
fi

# TODO: this is used in both the .bashrc and .zshrc; it should be moved to one location
# this method creates the command prompt
function precmd() {
    # check if wireguard is running on utun6
    # TODO: this is kinda a dumb way of doing this
	# Check for ifconfig and ip command existence
	ifcfg_check=$(command -v ifconfig)
	ip_check=$(command -v ip)

	# Determine VPN status based on available commands
	if [[ $(uname) == "Darwin" ]]; then
		vpn_check=$(wg show 2>&1) # this is cursed, but we check even if it fails
	elif [[ -n "$ip_check" ]]; then
	    vpn_check=$(ip addr | grep wg0)
	else
	    vpn_check=""
	fi
	# Set VPN_STATUS variable based on the result
	if [[ -z "$vpn_check" ]]; then
	    export VPN_STATUS=""
	else
	    export VPN_STATUS="(wg) "
	fi

    git_status=""
	if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch=$(git rev-parse --abbrev-ref HEAD)
        git_status="[$git_branch]"
        # Check if there are changes in the repo
        if [[ -n "$(git status --porcelain)" ]]; then
            git_status+="*"
        fi
    fi
    export GIT_STATUS=$git_status
    export TERM_DATE="[$(date "+%H:%M:%S")]"

	# VENV
	if [[ -z $VIRTUAL_ENV ]] || [[ ! $(which python) =~ $VIRTUAL_ENV ]]; then
		export VENV_STATUS=""
	else
		export VENV_STATUS="($(basename $VIRTUAL_ENV)) "
	fi
}

# Set the prompt for Bash
function set_prompt() {
	precmd
	PS1="$VENV_STATUS\[\033[0;32m\]$VPN_STATUS\[\033[1m\]\u@\h\[\033[0m\] \[\033[0;36m\]$TERM_DATE\[\033[0m\] \[\033[0m\][\w] \[\033[0;35m\]$GIT_STATUS\[\033[0m\]
\$ "
}

# Call set_prompt to initialize
set_prompt

# Update prompt before every command
export PROMPT_COMMAND=set_prompt
