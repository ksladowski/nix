{
  lib,
  config,
  baseVars,
  ...
}:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
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
