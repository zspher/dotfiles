{
  pkgs,
  config,
  self,
  inputs,
  ...
}:
{
  xdg.configFile."nvim/init.lua".enable = false;
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/configs/nvim";
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withNodeJs = true;
      extraPackages = with pkgs; [
        mermaid-cli # mermaid preview
        tree-sitter # needed for nvim-treesitter rewrite
        inotify-tools # better file watching

        #-- spelling
        # harper

        #-- rust
        rust-analyzer # LSP, required by rustaceanvim

        #-- lua
        lua-language-server # LSP
        stylua # formatter

        #-- nix
        nixfmt # formatter
        nixd # LSP

        #-- python
        python3Packages.debugpy
        pyright # LSP
        ty # LSP
        ruff # linter & formatter via LSP

        #-- c/c++, meson
        vscode-extensions.vadimcn.vscode-lldb.adapter # DAP
        # nix-vscode-extensions.vscode-marketplace-universal.vadimcn.vscode-lldb.adapter # DAP
        mesonlsp # LSP
        clang-tools

        #-- c#
        # roslyn-ls # LSP
        self.packages.${pkgs.stdenv.hostPlatform.system}.csharp-tools # LSP

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
