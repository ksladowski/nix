{ pkgs, config, lib, ... }:
{
  sops.secrets.hashedPassword.neededForUsers = true;
 
  ## TODO move this
  users.mutableUsers = false;

  users.users.kevin = {
    isNormalUser = true;
    extraGroups = [ 
	    "network"
	    "wheel" 
      "input"
      "bluetooth"
    ];
    hashedPasswordFile = config.sops.secrets.hashedPassword.path;
  };

  home-manager.users.kevin = ../../home/common;
}
