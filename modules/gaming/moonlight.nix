{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.moonlight;
in
{
  options.systemSettings.moonlight = with lib; {
    enable = mkEnableOption "moonlight";
  };

  config = lib.mkIf cfg.enable {

    hm = {
      home.packages = with pkgs; [
        moonlight-qt
      ];
    };

    hm-persist.files = [
      ".config/Moonlight Game Streaming Project/Moonlight.conf"
    ];

  };

}
