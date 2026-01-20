{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ xwayland-satellite ];

  programs.niri.enable = true;
  security.soteria.enable = true;
  security.pam.services.swaylock = { };

}
