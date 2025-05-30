{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vivid
  ];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    history.path = "${config.xdg.stateHome}/zsh/history";
    shellAliases = {
      wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
    };

    initExtraFirst = ''
      WORDCHARS=$WORDCHARS:s:/:
      setopt autopushd
    '';
    initExtraBeforeCompInit = ''
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      source "''${ZINIT_HOME}/zinit.zsh"
    '';
    completionInit = "";
    initExtra = builtins.readFile ./plugins.zsh;
  };
}
