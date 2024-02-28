#!/usr/bin/env bash

window_title=$(hyprctl activewindow -j | jq -r ".class")

if [[ $window_title == "Steam" ]]; then
    xdotool windowunmap "$(xdotool getactivewindow)"
else
    hyprctl dispatch killactive
fi
