{ config, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = config.services.gpg-agent.enable;
    };
  };
  catppuccin.lazygit.enable = true;
}
