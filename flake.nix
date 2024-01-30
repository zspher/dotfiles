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

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:zspher/ctp-nix";
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
          ./system
          ./system/pc.nix
          {system.stateVersion = "23.11";}
        ];
      };
      "pi" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit data;};
        modules = [
          ./system
          ./system/pi.nix
          {system.stateVersion = "23.11";}
        ];
      };
    };
    homeConfigurations = {
      basic = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        extraSpecialArgs = {inherit inputs data;};
        modules = [
          ./configs
          ./configs/hyprland
          ./configs/home-manager.nix
          {home.stateVersion = "23.11";}
        ];
      };
    };
  };
}
