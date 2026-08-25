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

        vicinae = prev.vicinae.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.25.0";
            src = final.fetchFromGitHub {
              owner = "vicinaehq";
              repo = "vicinae";
              tag = "v${finalAttrs.version}";
              hash = "sha256-sK5o7d3Toq38F5uGwx+x6D/ZP6rxTPcjrDlR40WDt9c=";
            };

            apiDeps = final.fetchNpmDeps {
              src = "${finalAttrs.src}/src/typescript/api";
              hash = "sha256-4FEaBDJK9abcgz+vptuL4wQ8zhp+wpLbbR4Y79BVhEg=";
            };

            extensionManagerDeps = final.fetchNpmDeps {
              src = "${finalAttrs.src}/src/typescript/extension-manager";
              hash = "sha256-pEgqFgvdz7Bcc+LznCI+KlD1XEfUuWFWjS24MJ7sx3k=";
            };

            buildInputs = oldAttrs.buildInputs ++ [ final.qt6.qttools ];
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
