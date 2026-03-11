{
  lib,
  config,
  ...
}:
let
  workstation = config.systemSettings.workstation.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf workstation {
    hm = lib.mkIf homeManager {
      services.swayidle.enable = true;
    };
  };
}
