{
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.tlp;
in
{
  options.systemSettings.tlp = {
    enable = lib.mkEnableOption "Enable tlp";
  };

  config = lib.mkIf cfg.enable {
    services.tlp.enable = true;
  };
}
