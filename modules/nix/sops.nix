{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.sshKeyPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
    ];
    defaultSopsFile = ../../secrets/secrets.yaml;
    secrets.hashedPassword.neededForUsers = true;
  };

  # this isn't part of sops-nix but is necessary to work with sops secret files
  # when deploying make sure to run "SSH_TO_AGE_PASSPHRASE=${systemd-ask-password} ssh-to-age -private-key -i [personal key] -o $HOME/.config/sops/age/keys.txt"
  hm.home = {
    packages = with pkgs; [
      ssh-to-age
      sops
    ];

    persistence."/persist".directories = lib.mkAfter [
      ".config/sops"
    ];
  };
}
