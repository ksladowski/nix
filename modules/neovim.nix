{
  lib,
  pkgs,
  config,
  ...
}:
{

  hm = {
    home = {
      packages = with pkgs; [
        tree-sitter
        stylua
        luarocks
        lua-language-server
        lua5_1
        nil
        nixfmt
        markdown-oxide
      ];

      persistence."/persist".directories = lib.mkAfter [
        ".local/share/nvim"
        ".local/state/nvim"
        ".cache/nvim"
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

  };
}
