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

    #-- c/c++
    clang-tools # LSP, formatter
    vscode-extensions.vadimcn.vscode-lldb.adapter # debugger

    #-- c#
    omnisharp-roslyn # lsp
    netcoredbg # debugger

    #-- lua
    lua-language-server # LSP
    stylua # formatter

    #-- nix
    alejandra # formatter
    nil # lsp

    #-- web: js ts markdown json
    prettierd # formatter
    biome # linter, formatter via LSP

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

    #-- rust
    clippy # linter
    rust-analyzer # LSP
  ];
}
