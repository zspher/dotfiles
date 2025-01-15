{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dbeaver-bin
  ];
  xdg.desktopEntries = {
    dbeaver-ce = {
      name = "dbeaver-ce";
      icon = "dbeaver";
      genericName = "Universal Database Manager";
      comment = "Universal Database Manager and SQL Client.";
      startupNotify = true;
      settings.StartupWMClass = "DBeaver";
      exec = "env GDK_BACKEND=x11 ${pkgs.dbeaver-bin}/bin/dbeaver %u";
      categories = [
        "IDE"
        "Development"
      ];
      mimeType = [
        "application/sql"
      ];
    };
  };
}
