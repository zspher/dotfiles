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

      extraPackages = with pkgs; [
        unzip # NOTE: for mason
        gnumake # NOTE: required by fzf-telescope
        tree-sitter

        #-- rust
        rust-analyzer # LSP  NOTE: required by rustaceanvim

        #-- lua
        lua-language-server # LSP
        stylua # formatter

        #-- nix
        alejandra # formatter
        nil # lsp

        #-- python
        pyright # LSP
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

        #-- json, javascript, typescript
        biome # LSP
      ];
    };
  };
}
