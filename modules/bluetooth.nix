{
  lib,
  config,
  baseVars,
  ...
}:
let
  bluetooth = config.systemSettings.bluetooth.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  options.systemSettings.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf bluetooth {

    hardware.bluetooth = {
      enable = true;
    };

    users.groups.bluetooth.members = [ baseVars.username ];

    persist = lib.mkIf impermanence {
      directories = [
        "/var/lib/bluetooth"
      ];
    };

  };
}
