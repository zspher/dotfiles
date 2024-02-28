{pkgs, ...}: {
  imports = [
    ./home-manager.nix
  ];
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    # for GTK stuff: easyeffects
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gcc
    clang
    gparted
  ];
}
