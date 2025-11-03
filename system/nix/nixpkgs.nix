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

        # NOTE: for sensitive copy support
        wl-clipboard = prev.wl-clipboard.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = "bugaevc";
            repo = "wl-clipboard";
            rev = "aaa927ee7f7d91bcc25a3b68f60d01005d3b0f7f";
            hash = "sha256-V8JAai4gZ1nzia4kmQVeBwidQ+Sx5A5on3SJGSevrUU=";
          };
        });

        # FIX: memory leak issues
        swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = "ErikReider";
            repo = "SwayNotificationCenter";
            rev = "0998431754abdb6d8145d62d5a7265db95b867a3";
            hash = "sha256-ub4mfjCPuG+dwxd7N3ovQiyQ9CG/QL6VG/THSiu1QRo=";
          };
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
