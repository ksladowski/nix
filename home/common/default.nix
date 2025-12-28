{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
      ./firefox.nix
      ./niri.nix
      ./vesktop.nix
      ./git.nix
      ./shell.nix
  ];

  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      emacs
      bitwarden-desktop
      bitwarden-cli
    ];

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
