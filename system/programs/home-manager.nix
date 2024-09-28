{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.home-manager.packages.${pkgs.system}.default
  ];
}
