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
      "Samsung Electric Company Odyssey G93SD HCSL201348" = {
        enable = true;
        mode = {
          width = 5120;
          height = 1440;
          refresh = 240.000;
        };
        position = {
          x = 0;
          y = 0;
        };
      };
      "PNP(XMD) Mi TV Unknown" = {
        enable = false;
        mode = {
          width = 1920;
          height = 1080;
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
