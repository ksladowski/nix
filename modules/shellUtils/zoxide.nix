{
  lib,
  config,
  ...
}:
let
  shellEnvironment = config.systemSettings.shellEnvironment.enable;
  impermanence = config.systemSettings.impermanence.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf (shellEnvironment && homeManager) {
    hm = {
      programs.zoxide.enable = true;
    };

    hm-persist = lib.mkIf impermanence {
      directories = [
        ".local/zoxide"
      ];
    };
  };
}
