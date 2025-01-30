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

      # cursor
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_replace underscore
      set fish_cursor_external line
      set fish_cursor_visual block
    '';
    functions = {
      fish_user_key_bindings = {
        body = ''
          fish_vi_key_bindings

          bind -e --key \cy

          bind -M insert \cy accept-autosuggestion
          bind -M insert \en forward-word

          bind -M insert \cn down-or-search
          bind -M insert \cp up-or-search
        '';
      };
    };
  };
}
