{
  lib,
  config,
  baseVars,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  config = lib.mkIf desktopEnv {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "niri-session"; # TODO probably shouldn't hardcode niri
          user = baseVars.username;
        };
      };
    };
  };
}
