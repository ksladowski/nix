{
  lib,
  inputs,
  baseVars,
  hostVars,
  config,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    # Let us use hm as shorthand for home-manager config
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" baseVars.username ])
  ];

  hm.home = {
    username = baseVars.username;
    homeDirectory = baseVars.homeDirectory;
    stateVersion = hostVars.stateVersion;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
