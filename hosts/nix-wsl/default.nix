{ inputs, hostVars, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.default ];

  systemSettings = {
    homeManager.enable = true;
  };

  wsl = {
    enable = true;
    conf = {
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
}
