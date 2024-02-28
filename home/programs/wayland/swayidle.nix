{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    swayidle
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = lib.mkIf (config.wayland.windowManager.hyprland.enable) [
      (with builtins;
        lib.concatStrings [
          "swayidle -w "
          "timeout ${toString (60 * 30)} 'swaylock -f' "
          "timeout ${toString (60 * 30 + 10)} 'hyprctl dispatch dpms off' "
          "resume 'hyprctl dispatch dpms on' "
          "before-sleep 'swaylock -f'"
        ])
    ];
  };
}
