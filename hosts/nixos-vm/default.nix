{ config, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

}
