{ inputs, pkgs, ... }:
let
  brave = inputs.brave.packages.${pkgs.stdenv.hostPlatform.system}.brave;
in
{
  programs.brave = {
    enable = true;
    package = brave; # TODO: remove when upstream changes
    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "oboonakemofpalcgghocfoadofidjkkk"; } # keepassxc
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # stylus
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "oemmndcbldboiebfnladdacbdfmadadm"; } # pdf viewer
      { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } # catppuccin mocha
      { id = "cnjifjpddelmedmihgijeibhnjfabmlf"; } # obsidian webclipper
    ];
    commandLineArgs = [
      "--password-store=basic" # to remove kwallet popup
    ];
  };
}
