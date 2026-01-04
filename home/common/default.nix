{ inputs, pkgs, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./alacritty.nix
    ./git.nix
    ./shell.nix
    ./neovim.nix
    ../../modules/home/discord
    ../../modules/home/bitwarden
    ../../modules/home/desktop
    ../../modules/home/firefox
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
      ];
  };

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
