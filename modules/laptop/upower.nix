{
  lib,
  config,
  ...
}:
let
  cfg = config.systemSettings.upower;
in
{
  options.systemSettings.upower = {
    enable = lib.mkEnableOption "Enable upower (battery)";
  };

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
  };
}
