{
  lib,
  config,
  baseVars,
  ...
}:
let
  workstation = config.systemSettings.workstation.enable;
in
{
  config = lib.mkIf workstation {
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
