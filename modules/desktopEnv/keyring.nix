{
  pkgs,
  lib,
  config,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf desktopEnv {
    services.gnome.gnome-keyring.enable = true;

    hm = lib.mkIf homeManager {
      home.packages = with pkgs; [ seahorse ];
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".local/share/keyrings"
      ];
    };
  };
}
