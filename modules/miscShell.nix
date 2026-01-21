{ pkgs, ... }:
let
  shellAliases = {

    o = "xdg-open";

    ll = "exa -al";
    tree = "exa -al --tree";

    lg = "lazygit";

    nrs = "sudo nixos-rebuild switch --flake ~/src/nix";
    ncd = "cd ~/src/nix";
    nfu = "nix flake update --flake ~/src/nix";
  };
in
{
  hm = {

    home = {
      packages = with pkgs; [
        grc
        fd
        more
      ];
    };

    programs.bat.enable = true;

    programs.zoxide.enable = true;

    # TODO separate this into a module and configure it. nerd font icons, no sponsor popup (b/c impermanence), etc
    programs.lazygit = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.yazi.enable = true;
    programs.htop.enable = true;

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
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        # { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
        {
          name = "pure";
          src = pkgs.fishPlugins.pure.src;
        }
        # { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
      ];
    };

  };
}
