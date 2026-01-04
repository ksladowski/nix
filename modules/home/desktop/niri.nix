{ inputs, pkgs, lib, osConfig, ... }:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  imports = [ 
    inputs.niri.homeModules.niri 
  ];

  programs.niri = {
    package = pkgs.niri;
    settings = {
      environment."NIXOS_OZONE_WL" = "1";

      input = {
        keyboard.numlock = true;
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = false;
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      gestures.hot-corners.enable = false;

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png";
      cursor.hide-when-typing = true;

      layout = {
        border.enable = false;
        focus-ring.enable = true;
        shadow.enable = true;
        default-column-width.proportion = 0.5;
      };

      hotkey-overlay.skip-at-startup = true;

      prefer-no-csd = true;

      window-rules = [
      {
        geometry-corner-radius = 
          let
          r = 12.0;
        in
        {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }
      ];

      layer-rules = [
        {
	  matches = [
		  {namespace = "^noctalia-overview*";}
	  ];
	  place-within-backdrop = true;
	}
      ];

      binds = {
        "Mod+Return".action.spawn = "ghostty";

        "Mod+Space".action.spawn = "fuzzel";

        "Mod+O" = {
          action.toggle-overview = {};
          repeat = false;
        };

        "Mod+Q" = {
          action.close-window = {};
          repeat = false;
        };

        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-or-workspace-down = {};
        "Mod+K".action.focus-window-or-workspace-up = {};
        "Mod+L".action.focus-column-right = {};

        "Mod+Shift+H".action.move-column-left = {};
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = {};
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = {};
        "Mod+Shift+L".action.move-column-right = {};

        "Mod+A".action.focus-column-first = {};
        "Mod+E".action.focus-column-last = {};
        "Mod+Shift+A".action.move-column-to-first = {};
        "Mod+Shift+E".action.move-column-to-last = {};

        "Mod+Grave".action.focus-monitor-next = {};
        "Mod+Shift+Grave".action.move-window-to-monitor-next = {};

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = {};
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = {};
        };
        "Mod+WheelScrollRight".action.focus-column-right = {};
        "Mod+WheelScrollLeft".action.focus-column-left = {};

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Shift+1".action.move-window-to-workspace = 1;
        "Mod+Shift+2".action.move-window-to-workspace = 2;
        "Mod+Shift+3".action.move-window-to-workspace = 3;
        "Mod+Shift+4".action.move-window-to-workspace = 4;
        "Mod+Shift+5".action.move-window-to-workspace = 5;
        "Mod+Shift+6".action.move-window-to-workspace = 6;
        "Mod+Shift+7".action.move-window-to-workspace = 7;
        "Mod+Shift+8".action.move-window-to-workspace = 8;
        "Mod+Shift+9".action.move-window-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = {};
        "Mod+BracketRight".action.consume-or-expel-window-right = {};

        "Mod+Shift+BracketLeft".action.consume-window-into-column = {};
        "Mod+Shift+BracketRight".action.expel-window-from-column = {};

        "Mod+M".action.maximize-column = {};
        "Mod+Shift+M".action.fullscreen-window = {};
        "Mod+Ctrl+M".action.expand-column-to-available-width = {};

        "Mod+Ctrl+C".action.center-visible-columns = {};

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+F".action.toggle-window-floating = {};
        "Mod+Shift+F".action.switch-focus-between-floating-and-tiling = {};

        "Mod+T".action.toggle-column-tabbed-display = {};

        "Print".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};

        "Mod+Escape" =
        {
          action.toggle-keyboard-shortcuts-inhibit = {};
          allow-inhibiting=false;
        };

        "Ctrl+Alt+Delete".action.quit = {};

        "Mod+Shift+P".action.power-off-monitors = {};

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ];
        };
      };
      outputs = lib.mkMerge [
        (lib.mkIf (osConfig.networking.hostName == "ray")
         {
         "eDP-1" = {
         enable = true;
       mode = {
         width = 1920;
	 height = 1200;
	 refresh = 60.0;
       };
         scale = 1.0;
         position = {
         x = 0;
         y = 0;
         };
         };
         })
         ## TODO call these out by name not port
      (lib.mkIf (osConfig.networking.hostName == "rex")
      {
       "DP-4" = {
       enable = true;
       mode = {
         width = 2560;
	 height = 1440;
	 refresh = 144.006;
       };
       position  = {
       x = 1920;
       y = 0;
       };
       };
       }
       )
      (lib.mkIf (osConfig.networking.hostName == "rex")
      {
       "DP-2" = {
       enable = true;
       mode = {
         width = 1920;
	 height = 1080;
	 refresh = 144.001;
       };
       position = {
       x = 0;
       y = 380;
       };
       };
       }
       )
      (lib.mkIf (osConfig.networking.hostName == "rex")
      {
       "HDMI-A-3" = {
       enable = false;
       mode = {
         width = 1920;
	 height = 1080;
	 refresh = 60.0;
       };
       scale = 1.0;
       position = {
         x = 0;
         y = 0;
       };
       };
       })
      ];
    };
  };
}
