{
  config,
  lib,
  pkgs,
  ...
}:
let
  moonlight = config.systemSettings.moonlight.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.moonlight = with lib; {
    enable = mkEnableOption "moonlight";
  };

  config = lib.mkIf moonlight {

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [
        moonlight-qt
      ];
    };

    hm-persist = lib.mkIf impermanence {
      files = [
        ".config/Moonlight Game Streaming Project/Moonlight.conf"
      ];
    };
  };

}
