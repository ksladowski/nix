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
            position = "left";
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                  enableColorization = true;
                  colorizeDistroLogo = true;
                  colorizeSystemIcon = "primary";
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
                  id = "Tray";
                  drawerEnabled = false;
                }
                {
                  id = "NotificationHistory";
                  hideWhenZero = true;
                }
              ];
              center = [
                {
                  id = "Clock";
                  formatHorizontal = "HH:mm ddd, MMM dd";
                  formatVertical = "HH mm - ddd dd MMM";
                  usePrimaryColor = true;
                }
              ];
              right = [
                {
                  id = "AudioVisualizer";
                }
                {
                  id = "SystemMonitor";
                  showGpuTemp = true;
                }
                {
                  id = "Workspace";
                  hideUnoccupied = false;
                  labelMode = "none";
                }
              ];
            };
          };
          osd = {
            location = "top_left";
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
          SystemMonitor = {
            enableDgpuMonitoring = false;
          };
          wallpaper = {
            enabled = true;
            directory = "~/Pictures/Wallpapers";
            overviewEnabled = true;
          };
          colorSchemes = {
            predefinedScheme = "Everforest";
          };
          location = {
            useFahrenheit = true;
          };
          dock.enabled = false;
        };
      };
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".cache/noctalia" # needed to persist wallpaper, last changelog seen, etc
        ".config/noctalia/colorschemes"
      ];

    };
  };
}
