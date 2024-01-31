{
  config,
  data,
  pkgs,
  lib,
  ...
}: let
  inherit (data) username;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages =
    lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";

  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
}
