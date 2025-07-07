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
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
