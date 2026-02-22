{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    workstation.enable = true;
    bluetooth.enable = true;
    amd.enable = true;

    steam.enable = true;
    sunshine.enable = true;

    wine.enable = true;
    hypervisor.enable = true;

    printing.enable = true;
    scanning.enable = true;

    super-slicer.enable = true;
    nextcloud-client.enable = true;
    element.enable = true;
    discord.enable = true;

  };
}
