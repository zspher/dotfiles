{ pkgs, ... }:
{
  imports = [
    ./easyeffects.nix
    ./mpv.nix
    ./obs-studio.nix
    ./spicetify.nix
  ];
  home.packages = with pkgs; [
    gimp3
    grimblast
    hyprpicker
    inkscape
    qimgv
    timg
  ];
}
