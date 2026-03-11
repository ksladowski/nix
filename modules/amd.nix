{
  lib,
  config,
  ...
}:
let
  amd = config.systemSettings.amd.enable;
in
{

  options.systemSettings.amd = {
    enable = lib.mkEnableOption "Enable AMD Graphics";
  };

  config = lib.mkIf amd {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.lact.enable = true;
  };
}
