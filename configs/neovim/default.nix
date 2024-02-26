{
  pkgs,
  config,
  ...
}: {
  xdg.configFile.nvim.source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/configs/neovim/nvim";
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
  home.packages = with pkgs; [
    cargo
    gnumake
    cmake
    lldb # c, c++, rust

    #-- lua
    lua-language-server
    stylua

    #-- nix
    alejandra
    nil

    #-- web: js ts markdown json
    prettierd
    biome

    #-- c#
    (with dotnetCorePackages;
      combinePackages [
        sdk_6_0
        sdk_8_0
      ])
    omnisharp-roslyn
    csharpier
    netcoredbg

    #-- c/c++
    clang-tools

    #-- python
    nodePackages_latest.pyright
    ruff-lsp

    #-- bash
    nodePackages_latest.bash-language-server
    shfmt
    shellcheck

    #-- xml
    lemminx
  ];
}
