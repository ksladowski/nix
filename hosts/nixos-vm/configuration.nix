{ config, lib, pkgs, ... }:

{
  imports =
    [
     ../../modules/system/bootloader.nix
     ../../modules/system/greetd.nix
     ../../modules/system/zsh.nix
     ../../modules/system/stylix.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  users.users.kevin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    wofi
    waybar
    emacs
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
