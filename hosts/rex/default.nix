{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./niri-outputs.nix
  ];

  systemSettings = {

    bluetooth.enable = true;

    # Gaming
    steam.enable = true;
    jackify.enable = true;

    hypervisor.enable = true;

    super-slicer.enable = true;

  };
}
