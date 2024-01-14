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
    utils = import ./lib/HM.nix;
    inherit (import ./config.nix) username system hostname keys;
  in {
    nixosConfigurations = {
      "pi" = lib.nixosSystem {
        modules = [
          ./system
          {
            networking.hostName = hostname;
            users.users = {
              "${username}" = {
                initialPassword = "defaultPass";
                isNormalUser = true;
                openssh.authorizedKeys = {inherit keys;};
                extraGroups = ["wheel" "networkmanager"];
              };
            };
          }
        ];
      };
    };
    homeConfigurations = {
      basic = utils.mkHMuser {
        inherit username;
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [
          ./configs/applications.nix
          ./configs/neovim
        ];
      };
    };
  };
}
