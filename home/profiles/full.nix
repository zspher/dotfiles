{ ... }:
{
  imports = [
    ../programs/documents
    ../programs/multimedia
    ../programs/security
    ../programs/terminal
    ../programs/utils
    ../programs/wayland
    ../programs/web

    ../misc/fonts.nix
    ../misc/theme
    ../misc/theme/gui.nix
    ../misc/xdg-dirs.nix
    ../misc/xdg.nix
  ];
}
