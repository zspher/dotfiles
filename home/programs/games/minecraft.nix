{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.fjordLauncher.packages.${pkgs.system}.fjordlauncher
  ];
}
