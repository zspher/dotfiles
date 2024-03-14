{...}: {
  programs.git = {
    enable = true;
    userName = "zspher";
    userEmail = "66728045+zspher@users.noreply.github.com";
    signing.key = "D5FF4680";
    signing.signByDefault = true;
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      status.short = true;
    };
    ignores = [".env"];
  };
}
