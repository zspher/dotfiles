{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    source-sans
    source-sans-pro
    roboto
    corefonts
    vistafonts
  ];
}
