{
  pkgs,
  self,
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
    (self.packages.${pkgs.system}.sddm-corners-theme.override { font = "CaskaydiaMono Nerd Font"; })
  ];
}
