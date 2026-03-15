{
  config,
  lib,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  config = lib.mkIf (desktopEnv && homeManager) {
    hm.programs.niri.settings.outputs = {
      "Chimei Innolux Corporation 0x1618 Unknown" = {
        enable = true;
        mode = {
          width = 1920;
          height = 1200;
          refresh = 60.0;
        };
        scale = 1.0;
        position = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
