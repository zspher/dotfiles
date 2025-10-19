{
  pkgs,
  config,
  self,
  inputs,
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
        unzip # for mason
        gnumake # required by fzf-telescope
        ueberzugpp # for image preview (fzf-lua)
        mermaid-cli # mermaid preview
        tree-sitter # needed for nvim-treesitter rewrite

        #-- spelling
        # harper

        #-- rust
        rust-analyzer # LSP, required by rustaceanvim

        #-- lua
        lua-language-server # LSP
        stylua # formatter

        #-- nix
        nixfmt # formatter
        nil # LSP for code actions only
        nixd # LSP

        #-- python
        python3Packages.debugpy
        pyright # LSP
        ruff # linter & formatter via LSP

        #-- c/c++, meson
        vscode-extensions.vadimcn.vscode-lldb.adapter # DAP
        mesonlsp # LSP
        clang-tools

        #-- c#
        self.packages.${pkgs.stdenv.hostPlatform.system}.csharp-devkit-wrapper
        # adds roslyn-ls & rzls

        #-- bash
        bash-language-server # LSP
        shfmt # formatter (bashls calls this)
        shellcheck # linter (bashls calls this)

        #-- XML
        lemminx # LSP

        #-- TOML
        taplo # LSP

        #-- JSON, CSS, ESLint JSON
        self.packages.${pkgs.stdenv.hostPlatform.system}.vscode-langservers-extracted # LSP

        #-- HTML
        superhtml # LSP
        self.packages.${pkgs.stdenv.hostPlatform.system}.markuplint # LSP

        #-- markdown
        marksman # LSP
        markdownlint-cli2 # linter, formatter

        #-- JSON, JavaScript, TypeScript
        biome # formatter, linter
        vscode-js-debug # DAP
        vtsls # LSP

        #-- Typst
        tinymist # LSP
        typstyle # formatter

        #-- HTML, tailwind
        emmet-language-server # LSP
        tailwindcss-language-server # LSP
        self.packages.${pkgs.stdenv.hostPlatform.system}.cssmodules-language-server # LSP

        #-- YAML
        yaml-language-server

        #-- latex
        texlab # LSP
        texlivePackages.latexindent # formatter

        #-- SQL & co
        sqlite
        sqlcmd
        sqlfluff

        #-- zig
        zls

        #-- go
        delve # debugger
        gopls # LSP
      ];
    };
  };
}
