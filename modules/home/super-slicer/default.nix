{ pkgs, config, ... }:
{

	home = {
		packages = with pkgs; [
			super-slicer-latest
		];
	};
}
