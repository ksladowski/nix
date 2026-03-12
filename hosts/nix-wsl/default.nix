{
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.nixos-wsl.nixosModules.default ];

  systemSettings = {
    homeManager.enable = true;
    shellEnvironment.enable = true;
  };

  wsl = {
    enable = true;
    wslConf = {
      automount = {
        enabled = true;
        mountFsTab = true;
      };
      network = {
        generateHost = true;
        generateResolvConf = true;
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
