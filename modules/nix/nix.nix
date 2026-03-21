{
  lib,
  hostVars,
  baseVars,
  config,
  inputs,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
in
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../../overlays/roslyn-ls.nix)
      inputs.neovim-nightly-overlay.overlays.default
    ];
  };
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      trusted-users = [ baseVars.username ];
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  hm = lib.mkIf homeManager {
    home = {
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake ~/src/nix";
        ncd = "cd ~/src/nix";
        nfu = "nix flake update --flake ~/src/nix";
        nds = "nix develop --flake ~/src/nix";
      };
    };
  };

  system.stateVersion = hostVars.stateVersion;
}
