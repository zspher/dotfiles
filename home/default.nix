{
  self,
  inputs,
  username,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    self.nixosModules.catppuccin
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;

  home.activation.setSddmAvatar = lib.hm.dag.entryAfter ["linkGeneration"] ''
    if [ -s /home/${username} ]; then
        run ${pkgs.acl}/bin/setfacl -m u:sddm:r /home/${username}/.face.icon
        run ${pkgs.acl}/bin/setfacl -m u:sddm:x /home/${username}
    fi
  '';
  home.activation.genKconfig = lib.hm.dag.entryBefore ["kconfig"] ''
    touch ${config.xdg.configHome}/kdeglobals
  '';
}
