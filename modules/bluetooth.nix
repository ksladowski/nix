{
  lib,
  config,
  baseVars,
  ...
}:
let
  cfg = config.systemSettings.bluetooth;
in
{
  options.systemSettings.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf cfg.enable {

    hardware.bluetooth = {
      enable = true;
    };

    users.groups.bluetooth.members = [ baseVars.username ];

    persist = {
      directories = [
        "/var/lib/bluetooth"
      ];
    };

  };
}
