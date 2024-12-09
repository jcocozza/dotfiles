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

## Workflow

The logic for dotfiles is "inverted" from the typical branching structure of a repository.
The "main" branch serves as a base branch and contains things that are standard to all machines.
On install, a new branch is created specific to that machine.
Any changes to that branch are specific to that machine and will never be propagated to other machines. (e.g. adding things like environment variables for a particular server)

Changes to the main branch, on the other hand, are intended to be propagated to other machines.
This is done with the `uypdate.sh` script.
The update just does a rebase on the machine-specific branch to include the new main branch changes.

## Useful notes

Adding other repositories is best done like this: `git submodule add <https://repo> <foldername>`
