{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "zspher";
      user.email = "66728045+zspher@users.noreply.github.com";
      core.editor = "nvim";
      init.defaultBranch = "main";
      status.short = true;
      diff.colorMoved = true;
    };
    signing.key = "63A15B00";
    signing.signByDefault = true;
    ignores = [
      ".env"
      ".direnv"
    ];
  };
}
