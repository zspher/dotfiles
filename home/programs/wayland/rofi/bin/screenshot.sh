#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
theme="$HOME"/.config/rofi/share/applet.rasi

# Screenshot
time=$(date +%Y-%m-%dT%X)
dir="$HOME"/Pictures/Screenshots
file="$dir/$time.png"

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

# Theme Elements
title='Screenshot'
mesg="DIR: ${dir}"

list_col='1'
list_row='5'
win_width='400px'

# Options
option_1="󰹑  capture screen"
option_2="󰆞  capture area"
option_3="  capture window"
option_4="󱇸  capture screen in 5s"
option_5="󰵱  capture screen in 10s"

# Rofi CMD
rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
        -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str "entry {placeholder: \"<span weight='bold'>$title</span>\";}" \
        -dmenu \
        -mesg "$mesg" \
        -theme "$theme"
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# countdown
countdown() {
    local ID=0
    for sec in $(seq "$1" -1 1); do
        ID=$(notify-send -t 1000 -r "$ID" "Taking shot in : $sec" -p)
        sleep 1
    done
}

notify() {
    local action
    action=$(notify-send -i "$file" "Screenshot Saved" "$file" -A "open")
    if [[ $action == "0" ]]; then
        qimgv "$file"
    fi
}

# Execute Command
run_cmd() {
    case $1 in
    "--screen")
        grimblast copysave output "$file"
        ;;
    "--area")
        grimblast -f copysave area "$file"
        ;;
    "--window")
        grimblast copysave active "$file"
        ;;
    "--window-5")
        countdown '5'
        grimblast copysave output "$file"
        ;;
    "--window-10")
        countdown '10'
        grimblast copysave screen "$file"
        ;;
    esac
    notify
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$option_1")
    run_cmd --screen
    ;;
"$option_2")
    run_cmd --area
    ;;
"$option_3")
    run_cmd --window
    ;;
"$option_4")
    run_cmd --window-5
    ;;
"$option_5")
    run_cmd --window-10
    ;;
esac
