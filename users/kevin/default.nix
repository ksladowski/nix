{ pkgs, config, lib, ... }:
{
  users.users.kevin = {
    isNormalUser = true;
    extraGroups = [ 
	    "network"
	    "wheel" 
      "input"
      "bluetooth"
    ];
  };
# TODO add hashed password and set users immutable

  home-manager.users.kevin = ../../home/common;
}
