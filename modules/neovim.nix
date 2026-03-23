{
  lib,
  pkgs,
  config,
  self,
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
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        withNodeJs = true;
        withPython3 = true;
        vimdiffAlias = true;
        extraPackages = with pkgs; [
          mermaid-cli
          tree-sitter
          inotify-tools
          luarocks
          lua5_1
          lua51Packages.jsregexp # for luasnip
          gcc

          lua-language-server
          stylua

          nixfmt
          nixd

          marksman

          roslyn-ls
          dotnet-sdk_10
        ];

      };

      xdg.configFile.nvim = {
        source = config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.home.homeDirectory}/src/nvim";
        recursive = true;
      };

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
