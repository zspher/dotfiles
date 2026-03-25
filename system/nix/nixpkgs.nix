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
      # roslyn-ls = inputs.nixpkgs-old-roslyn-ls.legacyPackages.${prev.system}.roslyn-ls;
      # })
      (final: prev: {
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

        # FIX: get rid of `NO_RESULT_CALLBACK_FOUND` error
        taplo = prev.taplo.overrideAttrs (
          finalAttrs: oldAttrs: {
            pname = "taplo";
            version = "0.10.0";

            src = prev.fetchFromGitHub {
              owner = "tamasfe";
              repo = "taplo";
              rev = "9ccd6fe7085f787e214cec7b8d2717d52023e4b4";
              hash = "sha256-+kXOHspC55iE0ClMxqIuUSPIAe4GUZviRPmdhCcHcts=";
            };

            cargoDeps = oldAttrs.cargoDeps.overrideAttrs (previousAttrs: {
              vendorStaging = previousAttrs.vendorStaging.overrideAttrs {
                inherit (finalAttrs) src;
                outputHash = "sha256-zO4/RW5DTxfhTaY/fhM7GloQ7ugooL5+XwHgcF3SNT8=";
              };
            });
          }
        );

        # FIX: rofi memory leak when mode switch
        rofi-unwrapped = prev.rofi-unwrapped.overrideAttrs (oldAttrs: {
          patches = [
            ./rofi.patch
          ];
        });

        # FIX: Weston broken on sddm
        # https://github.com/NixOS/nixpkgs/pull/498269
        weston = prev.weston.overrideAttrs (oldAttrs: {
          patches = [
            (prev.fetchpatch {
              name = "weston-upstream-assertion-fix.patch";
              url = "https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1993.patch";
              hash = "sha256-705GIM7drTzv0N5Hk5dO18LWBnhhi1VoX8sfITHRYc4=";
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
