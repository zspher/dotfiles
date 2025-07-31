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
        swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (oldAttrs: {
          mesonBuildType = "release";
          patches = [
            ./swaync-textwrap-mpris.patch
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
