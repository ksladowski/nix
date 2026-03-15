{
  config,
  lib,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  config = lib.mkIf desktopEnv {
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };
}
