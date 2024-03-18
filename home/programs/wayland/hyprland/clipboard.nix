{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    xclip
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    (lib.concatStrings [
      "wl-paste -t text -w "
      "sh -c 'v=$(cat); cmp -s <(xclip -selection clipboard -o)  <<< \"$v\" || "
      "xclip -selection clipboard <<< \"$v\"'"
    ])
  ];
}
