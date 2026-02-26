{ ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  systemSettings = {
    pelican.enable = true;
    cloudflared.enable = true;
  };
}
