{
  lib,
  config,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
in
{
  hm = lib.mkIf homeManager {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Kevin Sladowski";
        email = "ksladowski@mailbox.org";
      };
    };
  };
}
