{ lib, config, ... }:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
    hm.programs.ghostty = {
      enable = true;
      settings = {
        background-opacity = 0.8;
        window-padding-x = 4;
        window-padding-y = 4;
        window-padding-balance = true;
        link-previews = false;
      };
      enableFishIntegration = true;
    };
  };
}
