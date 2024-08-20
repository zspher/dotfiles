{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # inputs.hyprland.nixosModules.default
  ];
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  environment.systemPackages = with pkgs; [
    kdePackages.qtwayland
  ];
}
