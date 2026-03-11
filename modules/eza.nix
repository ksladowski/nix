{ lib, config, ... }:
let
  workstation = config.systemSettings.workstation.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf workstation {
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
