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
  home.activation.fixOpenWith = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    menu_dir=${config.xdg.configHome}/menus
    if [[ ! -e "$menu_dir/applications.menu" ]]; then
      mkdir -p "$menu_dir"
      cp -f "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu" \
        "$menu_dir/applications.menu"

      rm ${config.xdg.cacheHome}/ksycoca6_*
      run ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6
    fi
  '';
}
