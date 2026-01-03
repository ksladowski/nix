{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ./nix.nix
    ./vim.nix
    ./niri.nix
    ./ssh.nix
    ../../modules/system/sudo
  ];

  time.timeZone = "America/Chicago";

  sops.age.sshKeyPaths = [ 
  "/persist/etc/ssh/ssh_host_ed25519_key" 
  ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  systemd.tmpfiles.rules = [
    "d /persist/home/kevin 0700 kevin users"
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
