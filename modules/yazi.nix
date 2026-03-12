{ lib, config, ... }:
let
  shellEnvironment = config.systemSettings.shellEnvironment.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf shellEnvironment {
    hm = lib.mkIf homeManager {

      # TODO plugins overlay
      # https://github.com/lordkekz/nix-yazi-plugins
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;
        shellWrapperName = "yazi";
        settings = {
          mgr = {
            show_hidden = true;
          };
        };
      };
    };
  };
}
