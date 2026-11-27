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
  home.activation.genFilesKconfig =
    let
      mkStub =
        x:
        let
          p = lib.escapeShellArg "${config.xdg.configHome}/${x}";
        in
        ''
          if [[ ! -e ${p} ]]; then
            run mkdir -p "$(dirname ${p})"
            run touch ${p}
          fi
        '';
    in
    lib.hm.dag.entryBetween [ "kconfig" ] [ "writeBoundary" ] ''
      ${lib.concatMapStrings mkStub (builtins.attrNames config.qt.kde.settings)}
    '';
}
