#! /usr/bin/env bash


installer() {
    sed -e 's/#.*//; /^\s*$/d;' "$1" | while read -r line; do # s/#.*// remove text after #
        # s/^ *// left trim
        # s/ *$// right trim
        # /^$/d delete empty line
        # ! unintended behaviour: the last line will not be printed
        # ! so add extra line in the end
        $2 "${line}"
    done
}

INSTALL_FILE="./aur.txt"
INSTALL_CMD="yay -S --noconfirm --needed"
installer "$INSTALL_FILE" "$INSTALL_CMD"

INSTALL_FILE="./flatpak.txt"
INSTALL_CMD="flatpak install -y --noninteractive"
installer "$INSTALL_FILE" "$INSTALL_CMD"
