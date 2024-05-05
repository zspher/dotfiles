{
  description = "IZBV personal dotfiles";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./system/profiles
        ./home/profiles
        ./packages
        ./modules
      ];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            nil
          ];
        };
        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pollymc = {
      url = "github:fn2006/PollyMC";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      # url = "github:anyrun-org/anyrun";
      # FIX: https://github.com/anyrun-org/anyrun/issues/124
      url = "github:fufexan/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    # pinned until FIX: https://github.com/catppuccin/nix/pull/159
    catppuccin.url = "github:catppuccin/nix/2788becbb58bd2a60666fbbf2d4f6ae1721112d5";
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
