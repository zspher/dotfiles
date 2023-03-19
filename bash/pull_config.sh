#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJ_DIR=$(dirname "$SCRIPT_DIR")

cp -r "$HOME/.bash_profile" "$PROJ_DIR/configs"

# * config dir
configs=(
    Kvantum
    latte
    dolphinrc
    latterdockrc
    zsh
    bottom
    cava
    kitty
    bat
    fontconfig
    vim
    starship.toml
    npm
    touchegg
    yay
    git
    gtk-2.0
    gtk-3.0
    gtk-4.0
    kde
    okularpartrc
    kdeglobals
    kwinrc
    Trolltech.conf
    kcminputrc
    kglobalshortcutsrc
    kwinrulesrc
    krunnerrc
    kxkbrc
    spicetify
)

for file in "${configs[@]}"; do
    cp -r "$HOME/.config/$file" "$PROJ_DIR/configs/.config"
    echo "$file"
done

# cp -r "$HOME/.config/" "$PROJ_DIR/configs/.config"
# git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
mkdir -p "$PROJ_DIR/configs/.config/nvim/lua/user"
cp -r "$HOME/.config/nvim/lua/user" "$PROJ_DIR/configs/.config/nvim/lua/"

# * .local/share
share=(
    color-schemes
    org.kde.syntax-highlighting
    plasma-systemmonitor
)

for file in "${share[@]}"; do
    cp -r "$HOME/.local/share/$file" "$PROJ_DIR/configs/.local/share"
    echo "$file"
done



# mv ~/.config/