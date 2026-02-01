{ baseVars, ... }:
{
  hardware.sane.enable = true;

  users.groups.scanner.members = [ baseVars.username ];
  users.groups.lp.members = [ baseVars.username ];
}
