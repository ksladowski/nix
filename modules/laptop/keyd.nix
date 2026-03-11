{
  lib,
  config,
  ...
}:
let
  laptop = config.systemSettings.laptop.enable;
in
{
  config = lib.mkIf laptop {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "0001:0001" ];
          settings = {
            main = {
              capslock = "layer(control)";
              leftcontrol = "esc";
            };
          };
        };
      };
    };

    # Optional, but makes sure that when you type the make palm rejection work with keyd
    # https://github.com/rvaiya/keyd/issues/723
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';
  };
}
