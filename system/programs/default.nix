{ pkgs, ... }:
{
  imports = [
    ./home-manager.nix
    ./npm.nix
    ./nh.nix
  ];
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
    fish.enable = true;

    # for GTK stuff: easyeffects
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clang
    curl
    gcc
    git
    kdePackages.partitionmanager
  ];
}
