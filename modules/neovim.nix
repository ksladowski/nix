{
  lib,
  pkgs,
  config,
  ...
}:
let
  shellEnvironment = config.systemSettings.shellEnvironment.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf shellEnvironment {
    hm = lib.mkIf homeManager {
      home = {
        packages = with pkgs; [
          tree-sitter
          stylua
          luarocks
          lua-language-server
          lua5_1
          nil
          nixfmt
        ];

      };

      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
      };

      xdg.configFile.nvim = {
        source = config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.home.homeDirectory}/src/nvim";
        recursive = true;
      };

      stylix.targets.neovim.enable = false;
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".local/share/nvim"
        ".local/state/nvim"
        ".cache/nvim"
      ];
    };
  };
}
