{
  pkgs,
  wallpaperDir ? "$HOME/Pictures/Wallpapers",
  timeout ? "400",
}:
pkgs.writeShellScriptBin "swww-wallset" ''
  #! /usr/bin/env bash
  ${pkgs.swww}/bin/swww init

  wallpaperDir="${wallpaperDir}"
  TIMEOUT=${timeout}

  if [ ! -d $wallpaperDir ]; then
      mkdir -p "$wallpaperDir"
  fi

  WALLPAPER=$(${pkgs.fd}/bin/fd . "$wallpaperDir" -tf -d 1 | shuf -n 1)
  PREVWALLPAPER=$WALLPAPER
  while true; do
      if [ "$WALLPAPER" == "$PREVWALLPAPER" ]; then
          WALLPAPER=$(${pkgs.fd}/bin/fd . "$wallpaperDir" -tf -d 1 | shuf -n 1)
      else
          PREVWALLPAPER=$WALLPAPER
          ${pkgs.swww}/bin/swww img "$WALLPAPER"
          printf "%s\n" "$WALLPAPER"
          sleep "$TIMEOUT"
      fi

  done

''
