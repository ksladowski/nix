{ lib, config, ... }:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {

      home.file.".config/ghostty/shaders".source = ../config/ghostty/shaders;

      programs.ghostty = {
        enable = true;
        settings = {
          background-opacity = 0.8;
          window-padding-x = 4;
          window-padding-y = 4;
          window-padding-balance = true;
          link-previews = false;
          custom-shader = "~/.config/ghostty/shaders/cursor_warp.glsl";
        };
        enableFishIntegration = true;
      };
    };
  };
}
