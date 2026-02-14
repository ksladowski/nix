{
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.amd;
in
{

  options.systemSettings.amd = {
    enable = lib.mkEnableOption "Enable AMD Graphics";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.lact.enable = true;
  };
}
