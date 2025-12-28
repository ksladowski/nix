{ inputs, outputs, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./niri.nix
  ];

   programs.home-manager.enable = true;

   programs.git = {
     enable = true;
     settings.user = {
       name = "Kevin Sladowski";
       email = "ksladowski@mailbox.org";
     };
   };

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
