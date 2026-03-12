{
  config,
  lib,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {
      home.file."Pictures/Wallpapers" = {
        source = config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.home.homeDirectory}/src/nix/walls";
        recursive = true;
      };
    };
  };
}
