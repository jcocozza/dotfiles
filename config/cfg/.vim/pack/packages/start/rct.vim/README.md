# rct.vim

The vim plugin that wraps the [rct](https://github.com/jcocozza/rct) tool.

## Rationale

Here is the basic problem that this plugin aims to solve:

When working in vim, occasionally one wants to copy text directly to the system clipboard.
This is usually done via `:"+y` or `:"*y` -- yanking into the buffer corresponding to the system clipboard.
This becomes problematic when working with vim on a remote machine.
Yanking into the system clipboard doesn't do anything useful because your local machine does not have access the remote's clipboard.
There are (of course) workarounds like X11 forwarding or tmux, but I've found that these are often frustrating to work with (for this purpose) and can be finicky.
Moreover, this assumes that you have a version of vim that has the +clipboard option.
Especially in restricted environments, this might not be feasible.

My solution was to develop a basic cross platform cli, [rct](https://github.com/jcocozza/rct), that sends text between machines.
This plugin is a wrapper around it.

The idea is to reproduce the behavior of `:"+y` or `:"*y` except from remote to local.
By default, yanks to the `q` register will be sent to local if things are set up properly.
If you want to use a different register, simply change it in your `.vimrc` with the global variable: `g:rct_register`.

## Installation

`rct.vim` requires `rct` to be [set up](https://github.com/jcocozza/rct?tab=readme-ov-file#setup) and installed.

## Basic Use

0. [rct](https://github.com/jcocozza/rct) is installed and configured on local and remote

1. On local machine

```bash
rct listen -d # run the rct listener in the background
```

2. By default any text yanked to `q` register will be sent to local by rct. Highlight text in vim, then `:"qy`.

3. Can now paste locally from the yanked text in vim
