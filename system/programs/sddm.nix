{
  pkgs,
  self,
  username,
  lib,
  ...
}:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-corners";
    wayland.enable = true;
    settings = {
      Theme = {
        CursorTheme = "Posy_Cursor";
        CursorSize = 24;
      };
      Wayland.CompositorCommand = "${lib.getExe pkgs.cage} -s -d";
    };
    extraPackages = with pkgs; [
      cage
    ];
  };

  environment.systemPackages = with pkgs; [
    posy-cursors
    (self.packages.${pkgs.stdenv.hostPlatform.system}.sddm-corners-theme.override {
      font = "CaskaydiaMono Nerd Font";
    })
  ];

  systemd.user.tmpfiles.users.${username}.rules = [
    "a+ /home/${username} - - - - m::x,u:sddm:x"
    "a+ /home/${username}/.face.icon - - - - m::r,u:sddm:r"
  ];
}
