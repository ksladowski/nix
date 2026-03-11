{
  pkgs,
  lib,
  config,
  ...
}:
let
  workstation = config.systemSettings.workstation.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{

  options.systemSettings.remmina = {
    enable = lib.mkEnableOption "Enable remmina";
  };

  config = lib.mkIf workstation {

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [
        remmina
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
