{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.pollymc.packages.${pkgs.system}.pollymc
  ];
}
