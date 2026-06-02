#!/usr/bin/env bash

sessions=$(tmux ls -F '#{session_name}' | grep '^[0-9]\+$' | sort -n)

for old in $sessions; do
  tmux rename-session -t "$old" "temp_$old"
done

new=1
for old in $sessions; do
  tmux rename-session -t "temp_$old" "$new"
  ((new++))
done
