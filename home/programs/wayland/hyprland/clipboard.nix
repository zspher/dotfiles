{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    wl-clipboard
    ydotool
    xclip
    zbar
  ];

  services.copyq.enable = true;

  # wayland.windowManager.hyprland.settings.exec-once = [
  #   (lib.concatStrings [
  #     # wayland <-> xwayand primary is enabled by default in hyprland
  #     # wayland <-> xwayand clipboard
  #     "wl-paste -t text -w sh -c "
  #     "'sleep 0.05 && [ \"$(xclip -selection clipboard -o)\" = \"$(wl-paste -n)\" ] "
  #     "|| xclip -selection clipboard'"
  #   ])
  # ];
}
