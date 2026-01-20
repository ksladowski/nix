{ lib, pkgs, config, ... }:
{

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
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/nvim";
    recursive = true;
  };
}
