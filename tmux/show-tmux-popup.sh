#!/usr/bin/env bash

POPUP_SESSION="popup"

export TMUX_PARENT_SESSION=$(tmux display-message -p '#S')

if ! tmux has-session -t "$POPUP_SESSION" 2>/dev/null; then
    tmux new-session -d -s "$POPUP_SESSION"
    
    # Clean up the UI
    tmux set-option -t "$POPUP_SESSION" status off
    
    # THE FIX: Tell this specific session to use your custom 'popup' key bindings 
    # instead of the standard 'root' bindings. This activates your 'bind -T popup' rules.
    tmux set-option -t "$POPUP_SESSION" key-table popup
fi

exec tmux attach-session -t "$POPUP_SESSION"
