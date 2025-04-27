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

      withNodeJs = true;
      extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
      extraPackages = with pkgs; [
        python3
        unzip # for mason
        gnumake # required by fzf-telescope
        tree-sitter
        ueberzugpp # for image preview (fzf-lua)

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

        #-- json, css, eslint json
        prettierd # formatter
        vscode-langservers-extracted # LSP

        #-- html
        superhtml # LSP

        #-- markdown
        marksman # LSP
        markdownlint-cli2 # linter, formatter

        #-- json, javascript, typescript
        biome # formatter, linter
        vscode-js-debug # DAP
        vtsls # LSP

        #-- typst
        tinymist
        typstyle

        #-- html, tailwind
        emmet-language-server # LSP
        tailwindcss-language-server # LSP

        #-- yaml
        yaml-language-server

        #-- latex
        texlab # LSP
        texlivePackages.latexindent # formatter

        #-- sql & co
        sqlcmd
        sqlfluff

        #-- zig
        zls
      ];
    };
  };
}
