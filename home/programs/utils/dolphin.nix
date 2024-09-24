{pkgs, ...}: {
  home.packages = with pkgs.kdePackages; [
    dolphin
    # https://invent.kde.org/frameworks/kimageformats
    kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    ffmpegthumbs # video thumbnails
    qtimageformats # for webp thumbnails
  ];
}
