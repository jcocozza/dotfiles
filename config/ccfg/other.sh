#!/bin/bash
#
# not sourced by anthing.
# ideas that I've had that I may add to the files in the future

tmux_keeper() {
    echo "blocking..."
    echo "ctrl+c to exit"
    tail -f /dev/null
}
