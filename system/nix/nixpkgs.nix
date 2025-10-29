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
      inputs.waybar.overlays.default
      (final: prev: rec {
        bottles-unwrapped = prev.bottles-unwrapped.overrideAttrs (oldAttrs: {
          propagatedBuildInputs = lib.lists.remove prev.gamescope oldAttrs.propagatedBuildInputs;
        });
        # .net 10 broke things
        roslyn-ls = inputs.nixpkgs-old-roslyn-ls.legacyPackages.${prev.system}.roslyn-ls;

        wl-clipboard = prev.wl-clipboard.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = "bugaevc";
            repo = "wl-clipboard";
            rev = "aaa927ee7f7d91bcc25a3b68f60d01005d3b0f7f";
            hash = "sha256-V8JAai4gZ1nzia4kmQVeBwidQ+Sx5A5on3SJGSevrUU=";
          };
        });

        # updates because I can't wait
        zathuraPkgs = prev.zathuraPkgs.overrideScope (
          selfx: prevx: {
            zathura_core = prevx.zathura_core.overrideAttrs (oldAttrs: rec {
              version = "0.5.13";
              src = prev.fetchurl {
                url = "https://pwmt.org/projects/zathura/download/zathura-${version}.tar.xz";
                hash = "sha256-YwIXO81G+JflIJyIOltRrR2rSUbC84YcujdKO4DY88E=";
              };
            });
          }
        );

      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
