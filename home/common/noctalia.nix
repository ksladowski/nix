{ inputs, lib, osConfig, ... }:
{

  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
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
          }
          {
            id = "MediaMini";
          }
          ];
          center = [
          {
            id = "NotificationHistory";
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
          (lib.mkIf (osConfig.networking.hostName == "ray")
           {
           id = "Brightness";
           }
          )
          {
            id = "Volume";
          }
          (lib.mkIf (osConfig.networking.hostName == "ray")
           {
           id = "Battery";
           alwaysShowPercentage = false;
           warningThreshold = 30;
           }
          )
          {
            id = "ControlCenter";
            useDistroLogo = true;
          }
          ];
        };
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
          (lib.mkIf (osConfig.networking.hostName == "ray")
            {
              enabled = true;
              id = "brightness-card";
            }
          )
          (lib.mkIf (osConfig.networking.hostName == "rex")
            {
              enabled = false;
              id = "brightness-card";
            }
          )
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = false;
            id = "media-sysmon-card";
          }
        ];
        wallpaper = {
          enabled = true;
          directory = "~/Pictures/Wallpapers";
        };
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
          right = [];
        };
      };
      dock.enabled = false;
    };
    systemd.enable = true;
  };
}
