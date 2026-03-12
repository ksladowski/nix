{ lib, config, ... }:
let
  shellEnvironment = config.systemSettings.shellEnvironment.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf shellEnvironment {
    hm = lib.mkIf homeManager {
      home = {
        shellAliases = {
          ll = "exa -al";
          tree = "exa -al --tree";
        };
      };

      programs.eza = {
        enable = true;
        icons = "auto";
        enableFishIntegration = true;
        git = true;
      };
    };
  };
}
