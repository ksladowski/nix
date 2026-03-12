{
  lib,
  ...
}:
{
  options.systemSettings.shellEnvironment = {
    enable = lib.mkEnableOption "Enable user space shell utilities";
  };
}
