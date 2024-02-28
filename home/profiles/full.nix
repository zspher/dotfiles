{...}: {
  imports = [
    ../programs/documents
    ../programs/multimedia
    ../programs/security
    ../programs/terminal
    ../programs/utils
    ../programs/wayland
    ../programs/web

    ../services

    ../misc/look-and-feel.nix
    ../misc/xdg-dirs.nix
    ../misc/xdg.nix
  ];
}
