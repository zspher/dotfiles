{
  pkgs,
  wallpaperDir ? "$HOME/Pictures/Wallpapers",
  timeout ? "400",
}:
pkgs.writeShellApplication {
  name = "swww-wallset";
  runtimeInputs = with pkgs; [
    swww
    fd
  ];
  text = ''
    #! /usr/bin/env bash
    wallpaperDir="${wallpaperDir}"
    TIMEOUT=${timeout}

    swww-daemon

    if [ ! -d "$wallpaperDir" ]; then
        mkdir -p "$wallpaperDir"
    fi

    WALLPAPER=$(fd . "$wallpaperDir" -tf -d 1 | shuf -n 1)
    PREVWALLPAPER=$WALLPAPER
    while true; do
        if [ "$WALLPAPER" == "$PREVWALLPAPER" ]; then
            WALLPAPER=$(fd . "$wallpaperDir" -tf -d 1 | shuf -n 1)
        else
            PREVWALLPAPER=$WALLPAPER
            swww img "$WALLPAPER"
            printf "%s\n" "$WALLPAPER"
            sleep "$TIMEOUT"
        fi

    done
  '';
}
