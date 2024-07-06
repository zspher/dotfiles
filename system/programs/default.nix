{pkgs, ...}: {
  imports = [
    ./home-manager.nix
    ./npm.nix
  ];
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    # for GTK stuff: easyeffects
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clang
    curl
    gcc
    git
    gparted
  ];
}
