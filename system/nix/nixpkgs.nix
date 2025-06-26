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
        rofi-calc = prev.callPackage ../../packages/rofi-calc { };
      })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
}
