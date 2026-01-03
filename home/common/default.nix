{ pkgs, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./alacritty.nix
    ./firefox.nix
    ./niri.nix
    ./git.nix
    ./shell.nix
    ./fuzzel.nix
    ./swayidle.nix
    ./noctalia.nix
    ./neovim.nix
    ../../modules/home/discord
    ../../modules/home/bitwarden
  ];

  programs.home-manager.enable = true;
  programs.fuse.userAllowOther = true;
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
      ];
  };

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
