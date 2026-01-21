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
      inputs.nix-vscode-extensions.overlays.default
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

        fishPlugins = prev.fishPlugins.overrideScope (
          selfx: prevx: {
            puffer = prevx.puffer.overrideAttrs (oldAttrs: rec {
              version = "1.1.0";
              src = prev.fetchFromGitHub {
                owner = "nickeb96";
                repo = "puffer-fish";
                rev = "v${version}";
                hash = "sha256-MdeegvBu/AqvaMu0g1UHKBvfb6SHUiTUiA62h87r/Xg=";
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
