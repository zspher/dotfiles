{ ... }:
{
  programs.brave = {
    enable = true;
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
