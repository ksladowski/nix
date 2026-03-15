{
  pkgs,
  lib,
  config,
  ...
}:
let
  remmina = config.systemSettings.remmina.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.remmina = {
    enable = lib.mkEnableOption "Enable remmina";
  };

  config = lib.mkIf remmina {
    hm = lib.mkIf homeManager {
      home.packages = [
        pkgs.remmina
      ];
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".cache/remmina"
        ".config/remmina"
        ".local/share/remmina"
      ];
    };
  };
}
