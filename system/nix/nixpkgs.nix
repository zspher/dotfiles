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

        # NOTE: for sensitive copy support
        wl-clipboard = prev.wl-clipboard.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = "bugaevc";
            repo = "wl-clipboard";
            rev = "aaa927ee7f7d91bcc25a3b68f60d01005d3b0f7f";
            hash = "sha256-V8JAai4gZ1nzia4kmQVeBwidQ+Sx5A5on3SJGSevrUU=";
          };
        });

        # inputs.waybar.overlays.default

        # NOTE: use cliphist 0.7.0
        # can't override buildGoModule other than replacing it *why?*
        cliphist = prev.callPackage (
          {
            lib,
            buildGoModule,
            fetchFromGitHub,
            nix-update-script,
          }:

          buildGoModule rec {
            pname = "cliphist";
            version = "0.7.0";

            src = fetchFromGitHub {
              owner = "sentriz";
              repo = "cliphist";
              tag = "v${version}";
              hash = "sha256-y4FSl/Bj80XqCR0ZwjGEkqYUIF6zJHrYyy01XPFlzjU=";
            };

            vendorHash = "sha256-4XyDLOJHdre/1BpjgFt/W6gOlPOvKztE+MsbwE3JAaQ=";

            postInstall = ''
              cp ${src}/contrib/* $out/bin/
            '';

            passthru = {
              updateScript = nix-update-script { };
            };

            meta = with lib; {
              description = "Wayland clipboard manager";
              homepage = "https://github.com/sentriz/cliphist";
              license = licenses.gpl3Only;
              platforms = platforms.linux;
              maintainers = with maintainers; [ dit7ya ];
              mainProgram = "cliphist";
            };
          }
        ) { };
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
