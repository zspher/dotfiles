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
in {
  flake.homeConfigurations = {
    "minimal" = homeManagerConfiguration {
      modules = [
        ../../system/nix/nixpkgs.nix
        ./..
        ./minimal.nix
      ];
      inherit pkgs extraSpecialArgs;
    };
    "desktop" = homeManagerConfiguration {
      modules = [
        ../../system/nix/nixpkgs.nix
        ./..
        ./full.nix
      ];
      inherit pkgs extraSpecialArgs;
    };
  };
}
