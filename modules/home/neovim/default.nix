{ lib, pkgs, config, ... }:
{

	home = {
		packages = with pkgs; [
      tree-sitter
			stylua
      alejandra
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
