{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
    hm.services.swayidle.enable = true;
  };
}
