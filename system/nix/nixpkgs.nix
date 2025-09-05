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
      (final: prev: rec {
        bottles-unwrapped = prev.bottles-unwrapped.overrideAttrs (oldAttrs: {
          propagatedBuildInputs = lib.lists.remove prev.gamescope oldAttrs.propagatedBuildInputs;
        });
        wl-clipboard = prev.wl-clipboard.overrideAttrs (oldAttrs: {
          version = "2.2.2";
          src = prev.fetchFromGitHub {
            owner = "bugaevc";
            repo = "wl-clipboard";
            rev = "aaa927ee7f7d91bcc25a3b68f60d01005d3b0f7f";
            hash = "sha256-V8JAai4gZ1nzia4kmQVeBwidQ+Sx5A5on3SJGSevrUU=";
          };
        });
        swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (oldAttrs: {
          mesonBuildType = "release";
          patches = [
            ./swaync-textwrap-mpris.patch
          ];
        });
        # .net 10 broke things
        roslyn-ls = inputs.nixpkgs-old-roslyn-ls.legacyPackages.${prev.system}.roslyn-ls;
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (python-final: python-prev: {
            # BUG: https://github.com/NixOS/nixpkgs/issues/437058 workaround
            # (breaks nwg-display)
            i3ipc = python-prev.i3ipc.overridePythonAttrs (oldAttrs: {
              doCheck = false;
              checkPhase = ''
                echo "Skipping pytest in Nix build"
              '';
              installCheckPhase = ''
                echo "Skipping install checks in Nix build"
              '';
            });
          })
        ];
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
