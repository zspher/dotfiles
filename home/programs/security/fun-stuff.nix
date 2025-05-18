{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # passwords
    (hashcat.override { cudaSupport = true; })

    # network
    nmap
    wireshark

    # reverse engineering
    (cutter.withPlugins (
      ps: with ps; [
        jsdec
        rz-ghidra
        sigdb
      ]
    ))
  ];
}
