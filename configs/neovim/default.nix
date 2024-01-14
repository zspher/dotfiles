{
  pkgs,
  config,
}: let
  neovim_src = ./nvim;
in {
  xdg.configFile."nvim/lua".source = neovim_src + "/lua";
  xdg.configFile."nvim/spell".source = neovim_src + "/spell";
  xdg.configFile."nvim/ftplugin".source = neovim_src + "/ftplugin";
  xdg.configFile."nvim/snippets".source = neovim_src + "/snippets";
  xdg.configFile."nvim/init.lua".source = neovim_src + "/init.lua";

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
