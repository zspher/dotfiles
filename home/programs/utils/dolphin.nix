{pkgs, ...}: {
  home.packages = with pkgs; [
    libsForQt5.dolphin
    libsForQt5.kio-extras # thumbnail service
    # https://invent.kde.org/frameworks/kimageformats
    libsForQt5.kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    libsForQt5.kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    libsForQt5.ffmpegthumbs # video thumbnails
  ];

  xdg.dataFile."kservices5/ServiceMenus/openKittyHere.desktop".text = ''
    [Desktop Entry]
    Type=Service
    ServiceTypes=KonqPopupMenu/Plugin
    MimeType=inode/directory;
    Actions=openKittyHere;
    X-KDE-Priority=TopLevel

    [Desktop Action openKittyHere]
    TryExec=kitty
    Exec=kitty -1 %f
    Name=Open Kitty Here
    Icon=utilities-terminal
    Comment=Opens a terminal at the current folder
  '';
}
