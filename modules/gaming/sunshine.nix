{
  config,
  lib,
  ...
}:

let
  sunshine = config.systemSettings.sunshine.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.sunshine = with lib; {
    enable = mkEnableOption "sunshine";
  };

  config = lib.mkIf sunshine {
    services.sunshine = {
      enable = true;
      openFirewall = true;
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".config/sunshine"
      ];
    };
  };
}
