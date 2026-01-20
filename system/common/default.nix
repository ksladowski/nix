{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ./nix.nix
    ./vim.nix
    ./ssh.nix
    ../../modules/system/niri
    ../../modules/system/sudo
    ../../modules/system/shell
    ../../modules/system/nfs
  ];

  time.timeZone = "America/Chicago";

  sops.age.sshKeyPaths = [
    "/persist/etc/ssh/ssh_host_ed25519_key"
  ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  programs.fuse.userAllowOther = true;
  systemd.tmpfiles.rules = [
    "d /persist/home/kevin 0700 kevin users"
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
