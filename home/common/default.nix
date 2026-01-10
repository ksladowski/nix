{ inputs, pkgs, ... }:
{
  imports = [
    ./git.nix
    ../../modules/home/discord
    ../../modules/home/bitwarden
    ../../modules/home/desktop
    ../../modules/home/firefox
    ../../modules/home/catppuccin
    ../../modules/home/ghostty
    ../../modules/home/shell
    ../../modules/home/neovim
    ../../modules/home/super-slicer
    ../../modules/home/jackify
  ];

  programs.home-manager.enable = true;
  home = {
    persistence."/persist" = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Games"
        "src"
        ".config/Bitwarden"
        ".config/vesktop"
        ".local/share/Steam"
        ".local/share/keyrings"
        ".mozilla"
	".cache/noctalia" # needed to persist wallpaper, last changelog seen, etc
	".ssh"
      ];
  };

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
