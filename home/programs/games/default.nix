{ pkgs, inputs, ... }:
{
  imports = [
    ./controller.nix
  ];
  home.packages = with pkgs; [
    # emulators / compatibility layer
    (bottles.override { removeWarningPopup = true; })
    cemu

    inputs.fjordLauncher.packages.${pkgs.stdenv.hostPlatform.system}.fjordlauncher
  ];
}
