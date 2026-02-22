{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  systemSettings = {
    pterodactyl-panel.enable = true;
  };
}
