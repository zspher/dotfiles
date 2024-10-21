{
  description = "IZBV personal dotfiles";
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        ./system/profiles
        ./home/profiles
        ./packages
        ./modules
      ];
      perSystem =
        {
          config,
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              nil
            ];
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=3f16bb4a40a55753cb84be9a54cd42c16222de6e";
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pollymc = {
      url = "github:fn2006/PollyMC";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };
    catppuccin-obs = {
      url = "github:catppuccin/obs";
      flake = false;
    };
    catppuccin-discord = {
      url = "github:catppuccin/discord?ref=gh-pages";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
