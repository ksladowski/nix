{ config, lib, pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./swayidle.nix
    ./noctalia.nix
    ./fuzzel.nix
  ];

  home.file."Pictures/Wallpapers" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/nix/theming/walls";
    recursive = true;
  };

  }
