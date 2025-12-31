{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ./nix.nix
    ./vim.nix
    ./niri.nix
    ./ssh.nix
  ];

  time.timeZone = "America/Chicago";

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.defaultSopsFile = ./secrets/secrets.yaml;

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
