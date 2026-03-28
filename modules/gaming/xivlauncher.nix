{
  config,
  lib,
  pkgs,
  ...
}:
let
  xivlauncher = config.systemSettings.xivlauncher.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.xivlauncher = with lib; {
    enable = mkEnableOption "xivlauncher";
  };

  config = lib.mkIf xivlauncher {

    hm = lib.mkIf homeManager {
      home.packages = [
        pkgs.xivlauncher
      ];
    };

    hm-persist = lib.mkIf impermanence {
      directories = [
        ".xlcore"
      ];
    };
  };

}
