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
    inherit (nixpkgs) lib;
    data = {inherit (import ./config.nix) username system hostname keys;};
    inherit (data) system;
  in {
    nixosConfigurations = {
      "pc" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs data;};
        modules = [
          ./system/base.nix
          ./system/pc.nix
          {system.stateVersion = "23.11";}
        ];
      };
      "pi" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit data;};
        modules = [
          ./system/pi.nix
          ./system/base.nix
          {system.stateVersion = "23.11";}
        ];
      };
    };
    homeConfigurations = {
      basic = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        extraSpecialArgs = {inherit data;};
        modules = [
          ./configs/applications.nix
          ./configs/base.nix
          {home.stateVersion = "23.11";}
        ];
      };
    };
  };
}
