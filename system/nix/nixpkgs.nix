{
  lib,
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
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
