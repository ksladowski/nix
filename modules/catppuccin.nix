{
  inputs,
  config,
  lib,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];
      catppuccin = {
        # enable = true;
        cursors.enable = true;
        ghostty.enable = true;
        firefox = {
          enable = true;
          profiles.default = {
            enable = true;
            force = true;
          };
        };
        fish.enable = true;
        fzf.enable = true;
        vesktop.enable = true;
        yazi.enable = true;
      };
    };
  };
}
