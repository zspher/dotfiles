{pkgs, ...}: {
  imports = [
    ./easyeffects.nix
    ./mpv.nix
    ./obs-studio.nix
    ./spicetify.nix
  ];
  home.packages = with pkgs; [
    gimp
    grimblast
    hyprpicker
    qimgv
    timg
  ];
}
