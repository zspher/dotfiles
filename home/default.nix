{
  self,
  inputs,
  username,
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    # inputs.walker.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default
    self.homeModules.catppuccin # requires catppuccin/nix
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;

  # create `qt.kde.settings` files if not present
  home.activation.genFilesKconfig = lib.hm.dag.entryBefore [ "kconfig" ] ''
    ${lib.concatMapStrings (
      x:
      let
        path = "${config.xdg.configHome}/${x}";
      in
      "[ ! -e ${path} ] && touch ${path}\n"
    ) (builtins.attrNames config.qt.kde.settings)}
  '';
}
