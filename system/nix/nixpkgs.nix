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
        # FIX: get rid of `NO_RESULT_CALLBACK_FOUND` error
        taplo = prev.taplo.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.10.0";

            src = final.fetchFromGitHub {
              owner = "tamasfe";
              repo = "taplo";
              rev = "b673b44df2773db8673a00df2e7654b769f7fde7";
              hash = "sha256-z+B0f6+PfLgEWeJodQ9xfzf1cuPPwZFfy/epPCiC4eU=";
            };

            patches = [ ];

            cargoDeps = final.rustPlatform.fetchCargoVendor {
              inherit (finalAttrs) src patches;
              hash = "sha256-9BF+S3QrPtbuWKEbEtqNq1dBAy7l1LDK/aMWL54TcmY=";
            };
          }
        );

        # FIX: rofi memory leak when mode switch
        rofi-unwrapped = prev.rofi-unwrapped.overrideAttrs (oldAttrs: {
          patches = [
            ./rofi.patch
          ];
        });

        grimblast = prev.grimblast.overrideAttrs (oldAttrs: {
          src = final.fetchFromGitHub {
            owner = "zspher";
            repo = "contrib";
            rev = "af596a3ae5c2ff594bdc36e74d04ad4719444a76";
            hash = "sha256-881P0wflMS4dMxgZjyYbXhUjoEX9ISQGorb0CQqP/YI=";
          };
        });

        zathuraPkgs = prev.zathuraPkgs.overrideScope (
          selfx: prevx: {
            # FIX: missing link numbering
            # wait for https://github.com/NixOS/nixpkgs/pull/511330
            zathura_core = prevx.zathura_core.overrideAttrs (oldAttrs: {
              __structuredAttrs = false;
            });
          }
        );

        vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [
            ./vesktop-dtls-fix.patch
          ];
        });

        darkly = prev.darkly.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.5.38";
            src = final.fetchFromGitHub {
              owner = "Bali10050";
              repo = "Darkly";
              tag = "v${finalAttrs.version}";
              hash = "sha256-u12imjPk4ZhOen/PgnLiNPML+5NmuKO0Ja4wQKU/Y8E=";
            };
          }
        );

        vicinae = prev.vicinae.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.22.0";
            src = final.fetchFromGitHub {
              owner = "vicinaehq";
              repo = "vicinae";
              tag = "v${finalAttrs.version}";
              hash = "sha256-f1d88cdqe1PfeuzY90JIRCoHKLV1Uuakc4TpSNvNBKA=";
            };
          }
        );

        #
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
