{ lib, config, ... }:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {
      programs.ghostty = {
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
  };
}
