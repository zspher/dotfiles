{ ... }:
{
  programs.git = {
    enable = true;
    userName = "zspher";
    userEmail = "66728045+zspher@users.noreply.github.com";
    signing.key = "63A15B00";
    signing.signByDefault = true;
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      status.short = true;
    };
    ignores = [
      ".env"
      ".direnv"
    ];
  };
}
