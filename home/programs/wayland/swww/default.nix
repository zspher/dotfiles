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
      "swww-daemon"
      "${script}/bin/swww-wallset"
    ];
  };
}
