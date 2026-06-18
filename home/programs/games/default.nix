{ pkgs, inputs, ... }:
{
  imports = [
    ./controller.nix
  ];
  home.packages = with pkgs; [
    # emulators / compatibility layer
    # (bottles.override { removeWarningPopup = true; })
    cemu
  ];
  programs.lutris = {
    enable = true;
    runners = {
      cemu.package = pkgs.cemu;
      pcsx2.package = pkgs.pcsx2;
    };
    winePackages = with pkgs; [ wine64Packages.full ];
    protonPackages = [ pkgs.proton-ge-bin ];
  };

  programs.prismlauncher = {
    enable = true;
  };
}
