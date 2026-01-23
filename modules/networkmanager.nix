{ baseVars, ... }:
{

  networking.networkmanager.enable = true;

  users.groups.network.members = [ baseVars.username ];
}
