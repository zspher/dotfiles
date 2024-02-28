{
  pkgs,
  lib,
  config,
  ...
}: let
  script = import ./swww-wallset.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = lib.mkIf (config.wayland.windowManager.hyprland.enable) [
      "${script}/bin/swww-wallset"
    ];
  };
}
