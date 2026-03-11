{
  lib,
  inputs,
  baseVars,
  hostVars,
  config,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
in
{
  options.systemSettings.homeManager = {
    enable = lib.mkEnableOption "Enable home manager";
  };

  imports = [
    # Always define the hm alias
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" baseVars.username ])
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkIf homeManager {
    hm.home = {
      username = baseVars.username;
      homeDirectory = baseVars.homeDirectory;
      stateVersion = hostVars.stateVersion;
    };

    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
  };
}
