# Dotfiles

This is the set of files I use for development.

Simple run the install script on any server and you should read to go.

## Installation

Install mode is either "safe" or "super". Shell Setup is either "bash" or "zsh".

Run the following command to set up a linux or macos machine:
```bash
curl -sSL https://raw.githubusercontent.com/jcocozza/dotfiles/main/install.sh | bash -s -- <install mode> <shell>
```

`<install mode>` is either "safe" or "super".
Use "safe" when installing on servers you don't have sudo access.
Use "super" when you can install with sudo.

`<shell>` is either "bash" or "zsh".

## Useful notes

Adding other repositories is best done like this: `git submodule add <https://repo> <foldername>`
