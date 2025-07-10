{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];
    shellAbbrs = { };
    shellAliases = {
      lsd = "lsd --group-directories-first";
      la = "lsd -lA";
      lu = "lsd -lA --total-size";
      lt = "lsd -lA --tree";
      l = "lsd -1A";
      ls = "lsd";
      o = "xdg-open";
    };
    shellInit = '''';
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    functions = {
      fzf-project-search = {
        body = ''
          set -l query (commandline -b)
          if set -l result (fd -t d --exact-depth 1 . ~/personal/ ~/Documents/ ~/personal/test ~/.config | fzf --query=$query)
              cd -- $result
              commandline -r -- ""
          end

          commandline -f repaint
        '';
      };
      fish_user_key_bindings = {
        body = ''
          fish_vi_key_bindings

          bind -M insert ctrl-y accept-autosuggestion
          bind -M insert alt-n forward-word

          bind -M insert ctrl-n down-or-search
          bind -M insert ctrl-p up-or-search

          bind -M insert ctrl-f fzf-project-search
          bind ctrl-f fzf-project-search
        '';
      };
    };
  };
}
