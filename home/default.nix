{
  self,
  inputs,
  username,
  config,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.spicetify-nix.homeManagerModule
    self.nixosModules.catppuccin
    self.nixosModules.swaync
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
