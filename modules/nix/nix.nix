{
  lib,
  hostVars,
  baseVars,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
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

  hm.home = {
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/src/nix";
      ncd = "cd ~/src/nix";
      nfu = "nix flake update --flake ~/src/nix";
      nds = "nix develop --flake ~/src/nix";
    };
  };

  system.stateVersion = hostVars.stateVersion;
}
