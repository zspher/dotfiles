{
  self,
  inputs,
  ...
}: let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (import ../../system/config.nix) username;
  extraSpecialArgs = {
    inherit inputs self username;
  };
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  mods = {
    "minimal" = [
      ../../system/nix
      ./..
      ./minimal.nix
    ];
    "full" = [
      ../../system/nix
      ./..
      ./full.nix
    ];
  };
in {
  flake.homeConfigurations = {
    "minimal" = homeManagerConfiguration {
      modules = mods.minimal;
      inherit pkgs extraSpecialArgs;
    };
    "minimalPi" = homeManagerConfiguration {
      modules = mods.minimal;
      inherit extraSpecialArgs;
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
    };
    "desktop" = homeManagerConfiguration {
      modules = mods.full;
      inherit pkgs extraSpecialArgs;
    };
    "desktop-games" = homeManagerConfiguration {
      modules =
        mods.full
        ++ [
          ../programs/games/minecraft.nix
          ../programs/games/controller.nix
          ../programs/games/bottles.nix
          # ../programs/multimedia/davinci-resolve.nix
        ];
      inherit pkgs extraSpecialArgs;
    };
  };
}
