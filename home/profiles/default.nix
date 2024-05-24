{
  self,
  inputs,
  ...
}: let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (import ../../system/config.nix) user;
  extraSpecialArgs = {
    inherit inputs self;
    username = user;
  };
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  mods = {
    "minimal" = [
      ./..
      ./minimal.nix
    ];
    "full" = [
      ./..
      ./full.nix
    ];
    "nixpkgs" = [../../system/nix/nixpkgs.nix];
  };
in {
  flake.homeConfigurations = {
    "minimal" = homeManagerConfiguration {
      modules = mods.minimal ++ mods.nixpkgs;
      inherit pkgs extraSpecialArgs;
    };
    "minimalPi" = homeManagerConfiguration {
      modules = mods.minimal ++ mods.nixpkgs;
      inherit extraSpecialArgs;
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
    };
    "desktop" = homeManagerConfiguration {
      modules = mods.full ++ mods.nixpkgs;
      inherit pkgs extraSpecialArgs;
    };
    "desktop-games" = homeManagerConfiguration {
      modules =
        mods.full
        ++ mods.nixpkgs
        ++ [
          ../programs/games/minecraft.nix
          # ../programs/multimedia/davinci-resolve.nix
        ];
      inherit pkgs extraSpecialArgs;
    };
  };
}
