{
  pkgs,
  lib,
  config,
  data,
  ...
}: let
  inherit (data) username;
in {
  home.packages = with pkgs; [
    swww
    (import ./swww-wallset.nix {inherit pkgs swww fd username;})
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = lib.mkIf (config.wayland.windowManager.hyprland.enable) [
      "swww-wallset"
    ];
  };
}
