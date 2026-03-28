{
  inputs,
  config,
  lib,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {
      imports = [ inputs.everforest.homeModules.everforest ];
      gtk.enable = true;
      everforest.enable = true;
    };
  };
}
