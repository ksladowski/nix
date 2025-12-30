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
            enableDrawer = false;
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
    };
    systemd.enable = true;
  };
}
