{ baseVars, hostVars, ... }:
{
  networking = {

    networkmanager.enable = true;
    hostName = hostVars.hostname;
  };

  users.groups.network.members = [ baseVars.username ];
}
