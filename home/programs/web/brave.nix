{...}: {
  programs.brave = {
    enable = true;
    extensions = [
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "oboonakemofpalcgghocfoadofidjkkk";} # keepassxc
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
      {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # vimium-c
      {id = "nacjakoppgmdcpemlfnfegmlhipddanj";} # pdf viewer for vimium-c
      {id = "mcbpblocgmgfnpjjppndjkmgjaogfceg";} # fireshot
      {id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";} # catppuccin mocha
    ];
  };
}
