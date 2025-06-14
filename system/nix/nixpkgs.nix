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

        calibre = prev.calibre.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [
            ./calibre-native-dialogs.patch
          ];
          preFixup =
            let
              popplerArgs = "--prefix PATH : ${prev.poppler-utils.out}/bin";
            in
            ''
              for program in $out/bin/*; do
                wrapProgram $program \
                  ''${qtWrapperArgs[@]} \
                  ''${gappsWrapperArgs[@]} \
                  --prefix PATH : ${
                    lib.makeBinPath [
                      prev.libjpeg
                      prev.libwebp
                      prev.optipng
                      prev.zenity
                    ]
                  } \
                  ${if true then popplerArgs else ""}
              done
            '';
        });
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
