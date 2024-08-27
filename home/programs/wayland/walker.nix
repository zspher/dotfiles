{pkgs, ...}: {
  programs.walker = {
    enable = true;
    runAsService = false;
    config = {
      activation_mode.labels = "123456789";
      activation_mode.use_alt = true;

      list.max_entries = 5;
    };
  };
  home.packages = [pkgs.libqalculate];
}
