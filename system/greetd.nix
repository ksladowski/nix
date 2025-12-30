{ config, pkgs, ... }:
{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet \
         --time --time-format '%I:%M %p | %a - %h | %F' \
          --cmd 'niri-session'";
        user = "greeter";
      };
    };
  };

  users.users.greeter = {
    isNormalUser = false;
    description = "greetd greeter user";
    extraGroups = [ "video" "audio" ];
    linger = true;
  };

  environment.systemPackages = with pkgs; [ tuigreet ];
}
