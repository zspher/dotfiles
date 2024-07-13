{...}: {
  programs.brave = {
    enable = true;
    extensions = [
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "oboonakemofpalcgghocfoadofidjkkk";} # keepassxc
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
      {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # vimium-c
      {id = "oemmndcbldboiebfnladdacbdfmadadm";} # pdf viewer
      {id = "mdddabjhelpilpnpgondfmehhcplpiin";} # explain and send screenshot
      {id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";} # catppuccin mocha
    ];
  };
}
