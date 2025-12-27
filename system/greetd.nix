{ config, pkgs, ... }:
{

## TODO migrate to niri flake for faster updates - need cachix first
  programs.niri.enable = true;

## TODO eventually plan to migrate all of these to HM config, just trying to get an environment set up right now
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};
  programs.waybar.enable = true;
  environment.systemPackages = with pkgs; [ alacritty fuzzel swaylock mako swayidle xwayland-satellite tuigreet ];
  environment.sessionVariables.NIXOS_OZONE_WL = 1;

  # Greeter

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

## TODO uncomment this once the other packages block is cleaned up
#  environment.systemPackages = with pkgs; [ tuigreet ];
}
