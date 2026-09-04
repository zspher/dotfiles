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
        barcode-reader-cli = pkgs.callPackage ./barcode-reader-cli { };
        csharp-tools = pkgs.callPackage ./csharp-tools { ms-dotnettools = ms-dotnettools; };
        cssmodules-language-server = pkgs.callPackage ./cssmodules-language-server { }; # unused
        django-language-server = pkgs.callPackage ./django-language-server { };
        django-template-lsp = pkgs.callPackage ./django-template-lsp { };
        lemminx-maven-ext = pkgs.callPackage ./lemminx-maven-ext { };
        libtexprintf = pkgs.callPackage ./libtexprintf { };
        ms-dotnettools = pkgs.callPackage ./ms-dotnettools.csharp { };
        netpad = pkgs.callPackage ./netpad { }; # unused
        odin4 = pkgs.callPackage ./odin4 { }; # unused
        sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme { };
        shrinkpdf = pkgs.callPackage ./shrinkpdf { };
        sqlpackage = pkgs.callPackage ./sqlpackage { }; # locked for now
      };
    };
}
