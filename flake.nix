{
  description = "IZBV personal dotfiles";
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
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
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              nil
              nixd
            ];
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    fjordLauncher = {
      url = "github:unmojang/FjordLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # anyrun = {
    #   url = "github:zspher/anyrun/updates";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    catppuccin.url = "github:catppuccin/nix";
    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
