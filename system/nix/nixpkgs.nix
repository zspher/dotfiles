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
        # .net 10 broke things
        roslyn-ls = inputs.nixpkgs-old-roslyn-ls.legacyPackages.${prev.system}.roslyn-ls;

        # updates because I can't wait
        grimblast = prev.grimblast.overrideAttrs (oldAttrs: {
          version = "0.1-unstable-2025-09-16";
          src = prev.fetchFromGitHub {
            owner = "hyprwm";
            repo = "contrib";
            rev = "9e73a0e753251fbc6e987bd13324886dc6ca8f9a";
            hash = "sha256-0TCggLT5bUMpJYoA8+EXs8Qu+D9sTVe6eOmsNetH8OI=";
          };
        });
        copyq = prev.copyq.overrideAttrs (oldAttrs: rec {
          version = "11.0.0";
          src = prev.fetchFromGitHub {
            owner = "hluk";
            repo = "CopyQ";
            rev = "v${version}";
            hash = "sha256-/t+8YsqeX0tlxwQDDNTalttCDIgGhpLbzYe3UqY04xM=";
          };
          patches = [ ];
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
