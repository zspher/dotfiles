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
      packages = rec {
        sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme { };
        shrinkpdf = pkgs.callPackage ./shrinkpdf { };
        markuplint = pkgs.callPackage ./markuplint { };
        cssmodules-language-server = pkgs.callPackage ./cssmodules-language-server { };
        sqlpackage = pkgs.callPackage ./sqlpackage { };

        ms-dotnettools = pkgs.callPackage ./ms-dotnettools.csharp { };
        csharp-tools = pkgs.callPackage ./csharp-tools { inherit ms-dotnettools; };
        netpad = pkgs.callPackage ./netpad { };
        vscode-langservers-extracted = pkgs.callPackage ./vscode-langservers-extracted { };
      };
    };
}
