{ lib, config, ... }:
{
  config = lib.mkIf config.systemSettings.workstation.enable {
    hm = {

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
