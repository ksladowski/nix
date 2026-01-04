{ inputs, pkgs, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./git.nix
    ../../modules/home/discord
    ../../modules/home/bitwarden
    ../../modules/home/desktop
    ../../modules/home/firefox
    ../../modules/home/catppuccin
    ../../modules/home/ghostty
    ../../modules/home/shell
    ../../modules/home/neovim
  ];

  programs.home-manager.enable = true;
  home = {
    persistence."/persist/home/kevin" = {
      allowOther = true;
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "src"
        ".config/nvim"
        ".config/Bitwarden"
        ".config/vesktop"
        ".local/share/Steam"
        ".local/share/keyrings"
        ".mozilla"
	".cache/noctalia" # needed to persist wallpaper, last changelog seen, etc
      ];
  };

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
