{ pkgs, inputs, ... }:
{
  imports = [
    ./controller.nix
  ];
  home.packages = with pkgs; [
    # emulators / compatibility layer
    bottles
    cemu

    inputs.fjordLauncher.packages.${pkgs.system}.fjordlauncher
  ];
}
