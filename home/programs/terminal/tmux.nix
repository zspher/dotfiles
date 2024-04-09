{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    plugins = with pkgs; [
    ];
  };
}
