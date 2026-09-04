{
  pkgs,
  config,
  self,
  inputs,
  lib,
  ...
}:
{
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/configs/nvim";
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withNodeJs = true;
      withPython3 = false;
      withRuby = false;
      extraPackages = with pkgs; [
        mermaid-cli # mermaid preview
        tree-sitter # needed for nvim-treesitter rewrite
        inotify-tools # better file watching
        gnumake # for luasnip
        self.packages.${pkgs.stdenv.hostPlatform.system}.libtexprintf # latex markdown symbols

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
        # self.packages.${pkgs.stdenv.hostPlatform.system}.django-language-server # LSP
        self.packages.${pkgs.stdenv.hostPlatform.system}.django-template-lsp # LSP

        #-- c/c++, meson
        vscode-extensions.vadimcn.vscode-lldb.adapter # DAP
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
        tombi # LSP

        #-- JSON, CSS, ESLint JSON
        vscode-langservers-extracted # LSP

        #-- HTML
        superhtml # LSP

        #-- markdown
        marksman # LSP
        markdownlint-cli2 # linter, formatter

        #-- JSON, JavaScript, TypeScript
        biome # formatter, linter
        vscode-js-debug # DAP
        vtsls # LSP
        vue-language-server
        typescript-go # LSP

        #-- Typst
        tinymist # LSP
        typstyle # formatter

        #-- HTML, tailwind
        emmet-language-server # LSP
        tailwindcss-language-server # LSP

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

        #-- java
        jdt-language-server

        #-- dart
        dart
      ];
    };
  };
  # java deps
  xdg.dataFile."nvim/java/debug".source =
    "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/";
  xdg.dataFile."nvim/java/test".source =
    "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/";
  xdg.dataFile."nvim/java/lombok.jar".source = "${pkgs.lombok.out}/share/java/lombok.jar";
}
