{ pkgs, config, ... }:
{
  home.packages = with pkgs.kdePackages; [
    dolphin
    # https://invent.kde.org/frameworks/kimageformats
    kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    ffmpegthumbs # video thumbnails
    qtimageformats # for webp thumbnails
  ];
  qt.kde.settings."baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

  # to fix `open with` in non-kde DEs
  xdg.configFile."menus/applications.menu" =
    let
      plasmaApplicationsMenu = pkgs.runCommandLocal "plasma-applications-menu" { } ''
        mkdir -p $out
        cp ${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu \
          $out/applications.menu
      '';
    in
    {
      source = "${plasmaApplicationsMenu}/applications.menu";
      onChange = ''
        rm ${config.xdg.cacheHome}/ksycoca6_*
        run ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6
      '';
    };
}
