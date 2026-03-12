{
  lib,
  config,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {
      services.swayidle.enable = true;
    };
  };
}
