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
        rizin = pkgs.callPackage ../../packages/rizin { };
        rizinPlugins = lib.recurseIntoAttrs rizin.plugins;
        cutter = pkgs.qt6.callPackage ../../packages/rizin/cutter.nix { inherit rizin; };
        cutterPlugins = lib.recurseIntoAttrs cutter.plugins;
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
