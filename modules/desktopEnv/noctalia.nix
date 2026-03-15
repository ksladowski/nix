{
  inputs,
  lib,
  config,
  ...
}:
let
  desktopEnv = config.systemSettings.desktopEnv.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf desktopEnv {
    hm = lib.mkIf homeManager {

      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;
        settings = {
          bar = {
            density = "compact";
            position = "top";
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "Workspace";
                  hideUnoccupied = false;
                  labelMode = "none";
                }
                {
                  id = "ActiveWindow";
                  maxWidth = 300;
                }
                {
                  id = "MediaMini";
                  maxWidth = 300;
                }
              ];
              center = [
                {
                  id = "NotificationHistory";
                  hideWhenZero = true;
                }
                {
                  id = "Clock";
                  formatHorizontal = "HH:mm ddd, MMM dd";
                  usePrimaryColor = true;
                }
              ];
              right = [
                {
                  id = "SystemMonitor";
                  showGpuTemp = true;
                }
                {
                  id = "Tray";
                  drawerEnabled = false;
                }
                {
                  id = "WiFi";
                }
                {
                  id = "Bluetooth";
                }
                (lib.mkIf config.systemSettings.laptop.enable {
                  id = "Brightness";
                })
                {
                  id = "Volume";
                }
                (lib.mkIf config.systemSettings.laptop.enable {
                  id = "Battery";
                  alwaysShowPercentage = false;
                  warningThreshold = 30;
                })
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
              ];
            };
          };
          appLauncher = {
            terminalCommand = "ghostty -e";
          };
          controlCenter = {
            cards = [
              {
                enabled = true;
                id = "profile-card";
              }
              {
                enabled = true;
                id = "shortcuts-card";
              }
              {
                enabled = true;
                id = "audio-card";
              }
              (lib.mkIf config.systemSettings.laptop.enable {
                enabled = true;
                id = "brightness-card";
              })
              {
                enabled = false;
                id = "weather-card";
              }
              {
                enabled = false;
                id = "media-sysmon-card";
              }
            ];
            shortcuts = {
              left = [
                {
                  id = "WiFi";
                }
                {
                  id = "Bluetooth";
                }
                {
                  id = "ScreenRecorder";
                }
                {
                  id = "KeepAwake";
                }
                {
                  id = "NightLight";
                }
              ];
              right = [ ];
            };
          };
          wallpaper = {
            enabled = true;
            directory = "~/Pictures/Wallpapers";
            overviewEnabled = true;
          };
          colorSchemes = {
            predefinedScheme = "Catppuccin";
          };
          dock.enabled = false;
        };
      };
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".cache/noctalia" # needed to persist wallpaper, last changelog seen, etc
      ];

    };
  };
}
