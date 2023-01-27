#! /usr/bin/env bash

XDG_CONFIG_HOME="$HOME/.config/aaa"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
XDG_CACHE_HOME="$HOME/.cache"

# from config
cp -r configs/.config/* "$HOME/.config"
cp configs/.bash_profile "$HOME"

# desktop tweaks
cp "desktop/gtk-border/gtk-3.0.css" "$HOME/.config/gtk-3.0/gtk.css"
cp "desktop/gtk-border/gtk-4.0.css" "$HOME/.config/gtk-4.0/gtk.css"