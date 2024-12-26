{
  inputs,
  self,
  lib,
  ...
}:
{
  perSystem =
    {
      pkgs,
      inputs',
      system,
      ...
    }:
    {
      _module.args.pkgs = import self.inputs.nixpkgs {
        inherit system;
        inherit
          ((import ../system/nix/nixpkgs.nix {
            inherit
              inputs
              self
              lib
              pkgs
              ;
          }).nixpkgs
          )
          overlays
          config
          ;
      };
      packages = {
        posy-cursor = pkgs.callPackage ./posy-cursor { };
        sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme { };
        fotokilof = pkgs.python311Packages.callPackage ./fotokilof { };
        lightly-qt6 = pkgs.callPackage ./lightly-qt6 { };
      };
    };
}
