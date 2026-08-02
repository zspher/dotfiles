{ pkgs, ... }:
{
  home.packages = with pkgs; [
    easyeffects
    at-spi2-core
  ];
  # services.easyeffects.enable = true;
  catppuccin.custom.easyeffects.enable = true;
}
