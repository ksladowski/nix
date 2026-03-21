{
  lib,
  pkgs,
  config,
  inputs,
  self,
  ...
}:
let
  homeManager = config.systemSettings.homeManager.enable;
in
{
  hm = lib.mkIf homeManager {

    home.packages = with pkgs; [
      dotnet-sdk_10
      dotnet-runtime_10
      dotnet-aspnetcore_10
      dotnet-ef
      csharpier
      netcoredbg
    ];
  };
}
