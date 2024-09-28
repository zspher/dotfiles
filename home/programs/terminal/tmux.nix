{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    # prefix = "C-Space";
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    extraConfig = ''
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
    plugins = with pkgs; [
      tmuxPlugins.yank
    ];
  };
}
