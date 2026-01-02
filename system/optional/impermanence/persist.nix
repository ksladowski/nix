{ inputs, ... }:
{
imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    directories = [
      "/var/log"
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"

      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

  fileSystems."/persist".neededForBoot = true;
}
