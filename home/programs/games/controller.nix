{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python3.pkgs.ds4drv # for ps4 controller on bluetooth
  ];
}
