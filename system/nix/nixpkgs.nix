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
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = lib.optional (
        pkgs.roslyn-ls.version == "4.13.0-3.24577.4"
      ) "dotnet-sdk-6.0.428";
    };
  };
}
