{ pkgs, ... }:
{
  services.cliphist = {
    enable = true;
    allowImages = false;
  };
  home.packages = [
    pkgs.wl-clipboard
  ];
}
