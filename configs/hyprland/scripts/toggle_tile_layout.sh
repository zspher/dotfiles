#!/usr/bin/env bash

layout=$(hyprctl getoptions general:layout -j | jq '.str' -r)
if [[ $layout = "master" ]]; then
    hyprctl keyword general:layout dwindle
elif [[ $layout = "dwindle" ]]; then
    hyprctl keyword general:layout master
fi