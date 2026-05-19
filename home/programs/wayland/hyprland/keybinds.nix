{
  pkgs,
  lib,
  ...
}:
let
  close_window = pkgs.writeShellApplication {
    name = "close-window";
    runtimeInputs = [ pkgs.xdotool ];
    text = builtins.readFile ./scripts/close_window.sh;
  };
  brightness = pkgs.writers.writePython3 "brightness" {
    libraries = [ pkgs.libnotify ];
    flakeIgnore = [
      "E501"
    ];
  } (builtins.readFile ./scripts/brightness.py);
  volume = pkgs.writers.writePython3 "volume" {
    libraries = [ pkgs.libnotify ];
    flakeIgnore = [
      "E501"
    ];
  } (builtins.readFile ./scripts/volume.py);
  gamemode = pkgs.writeShellApplication {
    name = "gamemode";
    text = builtins.readFile ./scripts/gamemode.sh;
  };
  hyprtabs = pkgs.writeShellApplication {
    name = "hyprtabs";
    text = builtins.readFile ./scripts/hyprtabs.sh;
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {

    };
    # extraConfig = ''
    #   # * =========  Resize window  ========= * #
    #
    #   bind = $mainMod, R, submap, resize
    #   submap = resize
    #       binde = , H, resizeactive, -20 0
    #       binde = , L, resizeactive, 20 0
    #       binde = , J, resizeactive, 0 -20
    #       binde = , K, resizeactive, 0 20
    #   bind = , escape, submap, reset
    #   submap = reset
    # '';
  };
}
