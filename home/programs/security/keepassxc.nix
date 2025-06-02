{
  pkgs,
  lib,
  ...
}:
let
  fdo = true;
in
lib.mkMerge [
  {
    home.packages = with pkgs; [
      keepassxc
    ];
    qt.kde.settings."keepassxc/keepassxc.ini" = {
      General.ConfigVersion = 2;
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
  (lib.mkIf fdo {

    qt.kde.settings."keepassxc/keepassxc.ini".FdoSecrets.Enabled = true;
    xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [ "keepassxc" ];
    systemd.user.services.keepassxc = {
      Unit = {
        Description = "KeePassXC";
        PartOf = [ "graphical-session.target" ];

      };

      Service = {
        ExecStart = "${pkgs.keepassxc}/bin/keepassxc --minimized";
        Restart = "on-abort";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  })
]
