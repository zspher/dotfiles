#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
theme="$HOME"/.config/rofi/share/applet.rasi

# Theme Elements
prompt='Screenshot'
mesg="DIR: $HOME/Pictures/Screenshots"

list_col='1'
list_row='5'
win_width='400px'

# Options
layout=$(cat <"$theme" | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
    option_1="󰹑 Capture Desktop"
    option_2="󰆞 Capture Area"
    option_3=" Capture Window"
    option_4="󱇸 Capture in 5s"
    option_5="󰵱 Capture in 10s"
else
    option_1="󰹑"
    option_2="󰆞"
    option_3=""
    option_4="󱇸"
    option_5="󰵱"
fi

# Rofi CMD
rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
        -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme "$theme"
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME"/Pictures/Screenshots
file="Screenshot_${time}.png"

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

# countdown
countdown() {
    local ID=0
    for sec in $(seq "$1" -1 1); do
        ID=$(notify-send -t 1000 -r "$ID" "Taking shot in : $sec" -p)
        sleep 1
    done
}

notify() {
    notify-send -i "$dir/$file" "Screenshot Saved" "$dir/$file"
}

# take shots
shotnow() {
    sleep 0.5 && grimblast -f copysave screen "$dir/$file"
}

shot5() {
    countdown '5'
    sleep 1 && grimblast -f copysave screen "$dir/$file"
}

shot10() {
    countdown '10'
    sleep 1 && grimblast -f copysave screen "$dir/$file"
}

shotwin() {
    sleep 1 && grimblast -f copysave active "$dir/$file"
}

shotarea() {
    sleep 1 && grimblast -f copysave area "$dir/$file"
}

# Execute Command
run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
        shotnow
    elif [[ "$1" == '--opt2' ]]; then
        shotarea
    elif [[ "$1" == '--opt3' ]]; then
        shotwin
    elif [[ "$1" == '--opt4' ]]; then
        shot5
    elif [[ "$1" == '--opt5' ]]; then
        shot10
    fi
    notify
    qimgv "$dir/$file"
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$option_1")
        run_cmd --opt1
        ;;
    "$option_2")
        run_cmd --opt2
        ;;
    "$option_3")
        run_cmd --opt3
        ;;
    "$option_4")
        run_cmd --opt4
        ;;
    "$option_5")
        run_cmd --opt5
        ;;
esac
