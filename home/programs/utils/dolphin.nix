{pkgs, ...}: {
  home.packages = with pkgs.libsForQt5; [
    dolphin
    kio-extras # thumbnail service
    # https://invent.kde.org/frameworks/kimageformats
    kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    ffmpegthumbs # video thumbnails
  ];
}
