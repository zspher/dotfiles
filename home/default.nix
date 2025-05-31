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
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default
    inputs.walker.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default
    self.homeModules.catppuccin
    self.homeModules.vivid
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
