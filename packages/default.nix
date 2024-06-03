{
  self,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    inputs',
    system,
    ...
  }: {
    _module.args.pkgs = import self.inputs.nixpkgs {
      inherit system;
      inherit ((import ../system/nix/nixpkgs.nix {inherit self lib;}).nixpkgs) overlays config;
    };
    packages = {
      catppuccin-obs = pkgs.callPackage ./catppuccin-obs {};
      posy-cursor = pkgs.callPackage ./posy-cursor {};
      sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme {};
      fotokilof = pkgs.python311Packages.callPackage ./fotokilof {};
    };
  };
}
