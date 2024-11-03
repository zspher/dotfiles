{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # inputs.hyprland.nixosModules.default
  ];
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  environment.sessionVariables.GSK_RENDERER = "ngl";
  environment.systemPackages = with pkgs; [
    kdePackages.qtwayland
  ];
}
