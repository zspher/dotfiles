{
  description = "IZBV personal dotfiles";
  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) { overrides = args.tackOverrides or { }; } // {
        inherit self;
      };
    in
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
              nixfmt-tree
              nil
              nixd
              stylua
              tack
            ];
          };
          formatter = pkgs.nixfmt-tree;
        };
    };
}
