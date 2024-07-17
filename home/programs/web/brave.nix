{...}: {
  programs.brave = {
    enable = true;
    extensions = [
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "oboonakemofpalcgghocfoadofidjkkk";} # keepassxc
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # vimium
      {id = "oemmndcbldboiebfnladdacbdfmadadm";} # pdf viewer
      {id = "mdddabjhelpilpnpgondfmehhcplpiin";} # explain and send screenshot
      {id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";} # catppuccin mocha
    ];
  };
}
