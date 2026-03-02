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
        p = "${config.xdg.configHome}/${x}";
      in
      "[ ! -e ${p} ] && mkdir -p $(dirname ${x}) && touch ${p}\n"
    ) (builtins.attrNames config.qt.kde.settings)}
  '';

  # FIX: home-manager broken on lix https://github.com/nix-community/home-manager/issues/8786
  home.activation.installPackages = lib.mkForce (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    nixProfileRemove home-manager-path
    if [[ -e ${config.home.profileDirectory}/manifest.json ]]; then
      run nix profile install ${config.home.path}
    else
      run nix-env -i ${config.home.path}
    fi
  '');
}
