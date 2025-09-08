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
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
