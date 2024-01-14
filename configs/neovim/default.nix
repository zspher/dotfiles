{
  pkgs,
  config,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
    };
  };
  home = {
    packages = with pkgs; [
      #-- lua
      lua-language-server
      stylua

      #-- nix
      alejandra
      nil
    ];
  };
}
