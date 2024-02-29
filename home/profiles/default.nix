{
  self,
  inputs,
  ...
}: let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  extraSpecialArgs = {
    inherit inputs self;
    username = "faust";
  };
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  inherit (import ./config.nix) homeImports;
in {
  flake.homeConfigurations = {
    "minimal" = homeManagerConfiguration {
      modules =
        [../../system/nix/nixpkgs.nix]
        ++ homeImports.minimal;
      inherit pkgs extraSpecialArgs;
    };
    "desktop" = homeManagerConfiguration {
      modules =
        [../../system/nix/nixpkgs.nix]
        ++ homeImports.desktop;
      inherit pkgs extraSpecialArgs;
    };
  };
}
