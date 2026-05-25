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

        # FIX: get rid of `NO_RESULT_CALLBACK_FOUND` error
        taplo = prev.taplo.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.10.0";

            src = prev.fetchFromGitHub {
              owner = "tamasfe";
              repo = "taplo";
              rev = "b673b44df2773db8673a00df2e7654b769f7fde7";
              hash = "sha256-z+B0f6+PfLgEWeJodQ9xfzf1cuPPwZFfy/epPCiC4eU=";
            };

            patches = [ ];

            cargoDeps = prev.rustPlatform.fetchCargoVendor {
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

        # FIX: bottles & lutris-free are broken
        # https://github.com/NixOS/nixpkgs/issues/513245
        openldap = prev.openldap.overrideAttrs (oldAttrs: {
          # doCheck = !prev.stdenv.hostPlatform.isi686;
          preCheck =
            oldAttrs.preCheck
            + lib.optionalString prev.stdenv.hostPlatform.isi686 ''
              rm -f tests/scripts/test*-sync*
            '';
        });

        grimblast = prev.grimblast.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = "zspher";
            repo = "contrib";
            rev = "1ec82014b167f709589c6ddd419a098a0fb2bdfb";
            hash = "sha256-igimsuClLuBwCi9ingeg4U54AeeozFHPppGiRsreXzo=";
          };
        });

        tombi = prev.tombi.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "1.0.0";

            src = prev.fetchFromGitHub {
              owner = "tombi-toml";
              repo = "tombi";
              tag = "v${finalAttrs.version}";
              hash = "sha256-4DW4A1JuwEX76i2eMhU7WsDRPimdKec1mY+21dYOxP0=";
            };

            cargoDeps = prev.rustPlatform.fetchCargoVendor {
              inherit (finalAttrs) src;
              hash = "sha256-wRraQ+2TWuRBcYOoTQpKENeAuzB8LoGwQGJ2RVRt3Xo=";
            };
          }
        );

        nwg-displays = prev.nwg-displays.overrideAttrs (
          finalAttrs: oldAttrs: {
            version = "0.4.3";

            src = prev.fetchFromGitHub {
              owner = "nwg-piotr";
              repo = "nwg-displays";
              tag = "v${finalAttrs.version}";
              hash = "sha256-f7x6PTsND0eprhqvIdkZdHujcCbkJnqoXIKeE0O/YPE=";
            };
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
