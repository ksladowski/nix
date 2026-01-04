{ pkgs, ... }:
let shellAliases = {

	o = "xdg-open";

	ll = "exa -al";
	tree = "exa -al --tree";

	lg = "lazygit";

	nrs = "sudo nixos-rebuild switch --flake ~/src/nix";
	ncd = "cd ~/src/nix";
};
in
{

	home = {
		packages = with pkgs; [
			grc
			yazi
			lazygit
		];
	};

	programs.eza = {
		enable = true;
		icons = "auto";
		enableFishIntegration = true;
		git = true;
	};

	programs.fzf.enable = true;
	programs.ripgrep.enable = true;

	programs.fish = {
		inherit shellAliases;
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
			'';
		plugins = [
		{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
		# { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
		{ name = "pure"; src = pkgs.fishPlugins.pure.src; }
		# { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
		{ name = "done"; src = pkgs.fishPlugins.done.src; }
		];
	};
}
