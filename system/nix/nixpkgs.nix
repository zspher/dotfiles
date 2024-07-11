{
  lib,
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.waybar.overlays.default
      (final: prev: {
        libsForQt5 = prev.libsForQt5.overrideScope (selfx: prevx: {
          kdeconnect-kde = prevx.kdeconnect-kde.overrideAttrs (oldAttrs: {
            cmakeFlags = [
              "-DMDNS_ENABLED=OFF"
            ];
          });
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };
}
