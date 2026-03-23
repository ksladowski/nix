{ config, pkgs, ... }:
{
  devshells.dotnet = {
    packages = with pkgs; [
      dotnet-sdk_10
      dotnet-runtime_10
      dotnet-aspnetcore_10

      dotnet-ef
      csharpier
      netcoredbg

      config.packages.csharp-tools
    ];

    env = [
      {
        name = "DOTNET_ROOT";
        value = "${pkgs.dotnet-sdk_10}/share/dotnet/";
      }
      {
        name = "DOTNET_ENVIRONMENT";
        value = "Development";
      }
      {
        name = "DOTNET_CLI_TELEMETRY_OPTOUT";
        value = "1";
      }
      {
        name = "DOTNET_CLI_HOME";
        value = "/tmp/dotnet-cli-home";
      }
      {
        name = "SSL_CERT_FILE";
        value = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      }
    ];

    bash.extra = ''
      mkdir -p $DOTNET_CLI_HOME
      chmod 755 $DOTNET_CLI_HOME

      # devshell manages PATH for packages automatically, but we preserve
      # your explicit Path addition here for robustness.
      export PATH=$PATH:$DOTNET_CLI_HOME/.dotnet/tools

      echo "Welcome to .NET $(dotnet --version) development environment!"
      echo "dotnet SDK version: $(dotnet --version)"
    '';
  };
}
