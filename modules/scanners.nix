{ pkgs, baseVars, ... }:
{
  hardware.sane.enable = true;

  users.groups.scanner.members = [ baseVars.username ];
  users.groups.lp.members = [ baseVars.username ];

  hm.home.packages = with pkgs; [
    simple-scan
  ];
}
