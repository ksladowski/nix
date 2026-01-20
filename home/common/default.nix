{ ... }:
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
        ".ssh"
        ".local/share/keyrings"
        ".local/share/Steam" # TODO need to figure out how to share HM and system config
      ];
    };

    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.11";

  };

}
