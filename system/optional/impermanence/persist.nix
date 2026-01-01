{ inputs, ... }:
{
imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
    ];

    files = [
      "/etc/machine-id"

      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
