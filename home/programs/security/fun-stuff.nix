{ self, pkgs, ... }:
{
  home.packages = with pkgs; [
    # passwords
    # (hashcat.override { cudaSupport = true; })

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

    # osint tools
    self.packages.${pkgs.stdenv.hostPlatform.system}.barcode-reader-cli
  ];
}
