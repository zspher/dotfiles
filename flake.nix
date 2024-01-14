{
  description = "IZBV personal dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) inputs;
    inherit (nixpkgs) lib;
    utils = import ./lib/HM.nix;
    system = "";
  in {
    nixosConfigurations = {};
    homeConfigurations = {
      basic = utils.mkHMuser {
        username = "faust";
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [
          ./configs/applications.nix
          ./configs/neovim
        ];
      };
    };
  };
}
