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

    #-- lua
    lua-language-server
    stylua

    #-- nix
    alejandra
    nil

    #-- web: js ts markdown json
    prettierd
    biome

    #-- python
    nodePackages_latest.pyright
    ruff-lsp

    #-- bash
    nodePackages_latest.bash-language-server
    shfmt
    shellcheck

    #-- xml
    lemminx
    #-- toml
    taplo # LSP

    #-- rust
    clippy
    rust-analyzer
  ];
}
