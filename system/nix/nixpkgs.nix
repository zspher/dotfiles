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

        # FIX: discord does not use correct appName
        #      from https://github.com/NixOS/nixpkgs/pull/505535
        obsidian = prev.obsidian.overrideAttrs (oldAttrs: {
          buildInputs = [
            prev.asar
            prev.jq
          ];
          buildPhase = ''
            runHook preBuild
            asar extract resources/app.asar app
            jq '.desktopName = "obsidian"' app/package.json > package.json
            mv package.json app/package.json
            asar pack app resources/app.asar
            runHook postBuild
          '';
        });

        # TODO: remove when PR upstreamed
        #       0.20.12 -> 0.20.13
        vicinae = inputs.nixpkgs-dev.legacyPackages.${prev.stdenv.hostPlatform.system}.vicinae;
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
