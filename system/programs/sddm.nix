{
  pkgs,
  self,
  username,
  ...
}:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-corners";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = [
    (self.packages.${pkgs.stdenv.hostPlatform.system}.sddm-corners-theme.override {
      font = "CaskaydiaMono Nerd Font";
    })
  ];

  systemd.user.tmpfiles.users.${username}.rules = [
    "a+ /home/${username} - - - - m::x,u:sddm:x"
    "a+ /home/${username}/.face.icon - - - - m::r,u:sddm:r"
  ];
}
