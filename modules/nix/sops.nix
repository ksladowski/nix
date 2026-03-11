{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
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
  hm = lib.mkIf homeManager {
    home = {
      packages = with pkgs; [
        ssh-to-age
        sops
      ];
    };

  };
  hm-persist = lib.mkIf (homeManager && impermanence) {
    directories = [
      ".config/sops"
    ];
  };
}
