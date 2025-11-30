{ config, lib, ... }:

    let shellAliases = {
      ll = "ls -al";
      ".." = "cd ..";
      "~" = "cd ~";
    };
in
{
  home.username = "kevin";
  home.homeDirectory = "/home/kevin";

  home.packages = [];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    inherit shellAliases;
  };
  programs.zsh = {
    enable = true;
    inherit shellAliases;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null; # use system package
    portalPackage = null; # use system package
    systemd.variables = [ "--all" ];
    settings = {
      "$mod" = "SUPER";
      monitor=",1920x1200,0x0,1";
      ecosystem = {
        enforce_permissions = true;
        no_update_news = true;
        no_donation_nag = true;
      };
      bind = [
          "$mod, Return, exec, kitty"
          "$mod, Space, exec, wofi --show drun"
	  "$mod, e, exec, emacs"
          "$mod, f, exec, firefox"
          "$mod, q, killactive"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
      exec-once = [
          "waybar"
      ];
    };
  };

  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"; 

  home.stateVersion = "25.11";
}
