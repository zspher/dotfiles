{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./substituters.nix
    ./nixpkgs.nix
  ];
  nix = {
    enable = true;
    package = pkgs.lixPackageSets.latest.lix;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: { flake = v; }) inputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    # gc =
    #   {
    #     automatic = true;
    #     options = "--delete-older-than 1w";
    #   }
    #   // (
    #     if builtins.hasAttr "home" config
    #     then {frequency = "weekly";}
    #     else {dates = "weekly";}
    #   );

    settings = {
      allow-import-from-derivation = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
