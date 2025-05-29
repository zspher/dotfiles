{ ... }:
{
  programs.vesktop = {
    enable = true;
    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = true;
      useQuickCss = true;
      disableMinSize = true;

      eagerPatches = false;
      enableReactDevtools = false;
      frameless = false;
      transparent = false;
      winCtrlQ = false;
      winNativeTitleBar = false;

      plugins = {
        MessageLogger = {
          enabled = true;
          ignoreSelf = true;
        };
        FakeNitro.enabled = true;
        CrashHandler.enabled = true;
        WebKeybinds.enabled = true;
        WebScreenShareFixes.enabled = true;
        BiggerStreamPreview.enabled = true;
        ReverseImageSearch.enabled = true;
        Experiments.enabled = true;
      };

      notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };
    };
  };
}
