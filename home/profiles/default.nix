{
  self,
  inputs,
  ...
}:
let
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
in
{
  flake.homeConfigurations = {
    "minimal" = homeManagerConfiguration {
      modules = mods.minimal;
      inherit pkgs extraSpecialArgs;
    };
    "${username}@ns-200" = homeManagerConfiguration {
      modules = mods.minimal;
      inherit extraSpecialArgs;
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
    };
    "${username}@c-100" = homeManagerConfiguration {
      modules = mods.full;
      inherit pkgs extraSpecialArgs;
    };
    "${username}@ls-2100" = homeManagerConfiguration {
      modules = mods.full ++ [
        ../misc/fonts.nix
        ../programs/security/fun-stuff.nix
        ../programs/games
        # ../programs/multimedia/davinci-resolve.nix
      ];
      inherit pkgs extraSpecialArgs;
    };
  };
}
