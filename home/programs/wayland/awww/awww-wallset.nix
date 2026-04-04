{
  pkgs,
  wallpaperDir ? "$HOME/Pictures/Wallpapers",
  timeout ? "400",
}:
pkgs.writeShellApplication {
  name = "awww-wallset";
  runtimeInputs = with pkgs; [
    awww
    fd
  ];
  text = ''
    #! /usr/bin/env bash
    wallpaperDir="${wallpaperDir}"
    TIMEOUT=${timeout}

    awww-daemon &

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
            awww img "$WALLPAPER"
            printf "%s\n" "$WALLPAPER"
            sleep "$TIMEOUT"
        fi

    done
  '';
}
