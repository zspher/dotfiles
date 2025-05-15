{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (hashcat.override { cudaSupport = true; })

    nmap
    wireshark
  ];
}
