{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    copyq
    wl-clipboard
    xclip
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    (lib.concatStrings [
      # wayland <-> xwayand primary is enabled by default in hyprland
      # wayland <-> xwayand clipboard
      "wl-paste -t text -w sh -c "
      "'sleep 0.05 && [ \"$(xclip -selection clipboard -o)\" = \"$(wl-paste -n)\" ] "
      "|| xclip -selection clipboard'"
    ])
  ];
}
