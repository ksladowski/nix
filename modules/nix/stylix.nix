{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  config = lib.mkIf desktopEnv {
    stylix = {
      enable = true;
      targets.neovim.enable = false; # this is the only one i am disabling
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      fonts = {
        serif = config.stylix.fonts.sansSerif;
        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono Nerd Font";
        };
      };
      cursor = {
        name = "Everforest cursors";
        package = pkgs.everforest-cursors;
        size = 24;
      };
    };
  };
}
