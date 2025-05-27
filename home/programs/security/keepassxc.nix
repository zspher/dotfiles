{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
  ];
  qt.kde.settings."keepassxc/keepassxc.ini" = {
    General.ConfigVersion = 2;
    FdoSecrets.Enabled = true;
    Browser.Enabled = true;
    GUI = {
      ApplicationTheme = "classic";
      CompactMode = true;
      MinimizeOnClose = true;
      MinimizeToTray = true;
      ShowTrayIcon = true;
      TrayIconAppearance = "monochrome-light";
    };
  };
}
