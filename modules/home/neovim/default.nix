{ config, ... }:
{

# TODO should probably put this in a dev shell? Depends how often I edit the nvim config
	home = {
		packages = with pkgs; [
			stylua
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
