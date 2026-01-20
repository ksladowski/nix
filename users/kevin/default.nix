{
  config,
  ...
}:
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGuI5zoHAtiH1KjV1QZUh+eZ9r50GrMH7Kjgb45+h0FA KevinSladowski"
    ];
  };

  home-manager.users.kevin = ../../home/common;
}
