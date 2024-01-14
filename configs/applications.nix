{pkgs, ...}: {
  home.packages = with pkgs; [btop kitty clang];
}
