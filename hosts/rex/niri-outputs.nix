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
      "ASUSTek COMPUTER INC VG27AQ1A S6LMQS059549" = {
        enable = true;
        mode = {
          width = 2560;
          height = 1440;
          refresh = 144.006;
        };
        position = {
          x = 1920;
          y = 0;
        };
      };
      "PNP(AOC) 24G2WG3- PIBMCJA000715" = {
        enable = true;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 144.001;
        };
        position = {
          x = 0;
          y = 380;
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
