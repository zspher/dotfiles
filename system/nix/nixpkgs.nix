{
  lib,
  self,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        kdePackages = prev.kdePackages.overrideScope (
          selfx: prevx: {
            kdeconnect-kde = prevx.kdeconnect-kde.overrideAttrs (oldAttrs: {
              cmakeFlags = oldAttrs.cmakeFlags ++ [
                "-DMDNS_ENABLED=OFF"
              ];
            });
          }
        );
        pstoedit = prev.pstoedit.overrideAttrs (oldAttrs: rec {
          version = "4.01";
          src = prev.fetchurl {
            url = "mirror://sourceforge/pstoedit/pstoedit-${version}.tar.gz";
            sha256 = "sha256-RZdlq3NssQ+VVKesAsXqfzVcbC6fz9IXYRx9UQKxB2s=";
          };
          patches = [ ];
          preConfigure = '''';
          nativeBuildInputs = with prev; [
            makeWrapper
            pkg-config
          ];
          postInstall = ''
            wrapProgram $out/bin/pstoedit \
              --prefix PATH : ${prev.lib.makeBinPath [ prev.ghostscript ]}
          '';
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
