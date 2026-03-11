{
  config,
  lib,
  hostVars,
  baseVars,
  ...
}:
let
  networkManager = config.systemSettings.networkManager.enable;
in
{
  options.systemSettings.networkManager = {
    enable = lib.mkEnableOption "Enable networkManager";
  };

  config = lib.mkIf networkManager {
    networking = {
      networkmanager.enable = true;
      hostName = hostVars.hostname;
    };

    users.groups.network.members = [ baseVars.username ];
  };
}
