{
  pkgs,
  lib,
  config,
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
      Security.LockDatabaseMinimize = true;
    };
  }
  (lib.mkIf fdo {
    qt.kde.settings."keepassxc/keepassxc.ini".FdoSecrets.Enabled = true;
    xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [ "keepassxc" ];
    systemd.user.services.keepassxc = {
      Unit = {
        Description = "KeePassXC";
        PartOf = [
          config.wayland.systemd.target
          "tray.target"
        ];
        After = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${pkgs.keepassxc}/bin/keepassxc --minimized";
        Restart = "on-failure";
      };

      Install.WantedBy = [
        config.wayland.systemd.target
        "tray.target"
      ];
    };
  })
]
