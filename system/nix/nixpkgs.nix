{
  lib,
  self,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        kdePackages = prev.kdePackages.overrideScope (
          selfx: prevx: {
            kdeconnect-kde = prevx.kdeconnect-kde.overrideAttrs (oldAttrs: {
              cmakeFlags = oldAttrs.cmakeFlags ++ [
                "-DMDNS_ENABLED=OFF"
              ];
            });
          }
        );
        # TODO: remove when https://nixpk.gs/pr-tracker.html?pr=353338 lands
        neatvnc = prev.neatvnc.overrideAttrs (oldAttrs: {
          patches = [
            ./patches/fix-ffmpeg.patch
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
