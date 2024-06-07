{
  pkgs,
  config,
  ...
}: {
  xdg.configFile.nvim.source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/configs/nvim";
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
    meson

    #-- rust
    rust-analyzer # LSP # required by rustaceanvim

    #-- lua
    lua-language-server # LSP
    stylua # formatter

    #-- nix
    alejandra # formatter
    nil # lsp

    #-- python
    nodePackages_latest.pyright # LSP
    ruff-lsp # linter, formatter via LSP

    #-- bash
    nodePackages_latest.bash-language-server # LSP
    shfmt # formatter
    shellcheck # linter

    #-- xml
    lemminx # LSP

    #-- toml
    taplo # LSP

    #-- json, html, css, eslint markdown json
    prettierd # formatter
    vscode-langservers-extracted # LSP
  ];
}
