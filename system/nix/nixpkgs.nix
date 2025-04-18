{
  lib,
  self,
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      # (final: prev: {
      #   kdePackages = prev.kdePackages.overrideScope (
      #     selfx: prevx: {
      #       kdeconnect-kde = prevx.kdeconnect-kde.overrideAttrs (oldAttrs: {
      #         cmakeFlags = oldAttrs.cmakeFlags ++ [
      #           "-DMDNS_ENABLED=OFF"
      #         ];
      #       });
      #     }
      #   );
      # })
      (final: prev: {
        copyq = prev.copyq.overrideAttrs (oldAttrs: rec {
          version = "10.0.0";
          src = prev.fetchFromGitHub {
            owner = "hluk";
            repo = "CopyQ";
            rev = "v${version}";
            hash = "sha256-lH3WJ6cK2eCnmcLVLnYUypABj73UZjGqqDPp92QE+V4=";
          };
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ prev.pkg-config ];
          patches = [
            (prev.fetchpatch {
              # Can be removed after next release
              name = "fix-qchar-construction-for-qt-6.9.patch";
              url = "https://github.com/hluk/CopyQ/commit/f08c0d46a239362c5d3525ef9c3ba943bb00f734.patch";
              hash = "sha256-dsDIUVJHFFqzZ3tFOcYdwol/tm4viHM0CRs6wYfVKbQ=";
            })
          ];

        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
