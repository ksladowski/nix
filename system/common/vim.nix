{ inputs, outputs, pkgs, ... }:
{
	programs.vim = {
		enable = true;
		defaultEditor = true;
		package = (pkgs.vim-full.override {  }).customize{
			name = "vim";
# Install plugins for example for syntax highlighting of nix files
			vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
				start = [ vim-nix vim-lastplace ];
				opt = [];
			};
			vimrcConfig.customRC = ''
				set number
				set autoindent 
				set expandtab 
				set tabstop=2 
				set shiftwidth=2
				set backspace=indent,eol,start
				syntax on
				" ...
				'';
		};
	};
}
