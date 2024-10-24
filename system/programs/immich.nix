{ config, lib, ... }:
{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/drive2/immich";
  };
  systemd.tmpfiles.rules =
    let
      immich = config.services.immich;
      ext_libs =
        builtins.concatMap
          (
            x:
            [ "d ${immich.mediaLocation}/${x} 755 ${immich.user} ${immich.group}" ]
            ++ [ "f ${immich.mediaLocation}/${x}/.immich 644 ${immich.user} ${immich.group}" ]
          )
          [
            "encoded-video"
            "library"
            "upload"
            "profile"
            "thumbs"
          ];

    in
    lib.mkIf (config.services.immich.enable) (
      [
        "d ${immich.mediaLocation} 755 ${immich.user} ${immich.group}"
      ]
      ++ ext_libs
    );
}
