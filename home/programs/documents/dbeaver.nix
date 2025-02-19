{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    dbeaver-bin
  ];
  xdg.desktopEntries = {
    dbeaver = {
      name = "dbeaver-ce";
      icon = "dbeaver";
      genericName = "Universal Database Manager";
      comment = "Universal Database Manager and SQL Client.";
      startupNotify = true;
      settings.StartupWMClass = "DBeaver";
      exec = "env WEBKIT_DISABLE_COMPOSITING_MODE=1 GDK_BACKEND=x11 ${lib.getExe pkgs.dbeaver-bin} %u";
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
