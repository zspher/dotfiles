{ pkgs, self, ... }:
{
  imports = [
    ./kitty
    ./dolphin.nix
    ./wakatime.nix
    ./idea.nix # TODO: remove after class
  ];
  home.packages = with pkgs; [
    kdePackages.ark
    brightnessctl
    gnome-pomodoro
    (nwg-displays.override { hyprlandSupport = true; })
    pavucontrol
    playerctl
    qdirstat
    wev

    self.packages.${pkgs.stdenv.hostPlatform.system}.sqlpackage
  ];
}
