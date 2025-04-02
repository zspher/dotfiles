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
        shrinkpdf = pkgs.callPackage ./shrinkpdf { };
        sqruff = pkgs.callPackage ./sqruff { };
      };
    };
}
