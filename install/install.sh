#! /usr/bin/env bash

INSTALL_FILE="./aur.txt"
AUR_HELPER="yay -S --noconfirm --needed"
# AUR_HELPER="echo"

sed -e 's/#.*//; /^\s*$/d;' $INSTALL_FILE | while read -r line
# s/#.*// remove text after #
# s/^ *// left trim
# s/ *$// right trim
# /^$/d delete empty line
# ! unintended behaviour: the last line will not be printed
# ! so add extra line in the end
do
    $AUR_HELPER "${line}"
done

