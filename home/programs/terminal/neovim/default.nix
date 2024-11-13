{
  pkgs,
  config,
  ...
}:
{
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/configs/nvim";
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;

      extraPackages = with pkgs; [
        unzip # for mason
        gnumake # required by fzf-telescope
        tree-sitter

        #-- rust
        rust-analyzer # LSP, required by rustaceanvim

        #-- lua
        lua-language-server # LSP
        stylua # formatter

        #-- nix
        nixfmt-rfc-style # formatter
        nil # lsp for code actions only
        nixd # lsp

        #-- python
        pyright # LSP
        ruff # linter & formatter via LSP

        #-- c/c++, meson
        vscode-extensions.vadimcn.vscode-lldb.adapter # DAP
        mesonlsp # LSP

        #-- c#
        roslyn-ls # LSP, formatter

        #-- bash
        bash-language-server # LSP
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
        biome # formatter, linter
        vscode-js-debug # DAP

        #-- html, tailwind
        emmet-language-server # LSP
        tailwindcss-language-server # LSP

        #-- latex
        texlab # LSP
        texlivePackages.latexindent # formatter
      ];
    };
  };
}
