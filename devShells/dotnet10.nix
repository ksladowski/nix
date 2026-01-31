{ pkgs }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    dotnet-sdk_10
    dotnet-runtime_10
    dotnet-runtime_8
    dotnet-aspnetcore_10

    dotnet-ef
    csharpier
    roslyn-ls
    netcoredbg
  ];

  shellHook = ''
    # Set DOTNET_ROOT to the correct location
    export DOTNET_ROOT="${pkgs.dotnet-sdk_10}"

    # Set the ASPNETCORE environment to Development
    export DOTNET_ENVIRONMENT=Development

    # Disable telemetry
    export DOTNET_CLI_TELEMETRY_OPTOUT=1

    # Set up temp directory for .NET
    export DOTNET_CLI_HOME="/tmp/dotnet-cli-home"
    mkdir -p $DOTNET_CLI_HOME
    chmod 755 $DOTNET_CLI_HOME

    # Add dotnet tools to PATH
    export PATH=$PATH:$DOTNET_CLI_HOME/.dotnet/tools 

    # specify certs
    export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    # Welcome message
    echo "Welcome to .NET $(dotnet --version) development environment!"
    echo "dotnet SDK version: $(dotnet --version)"
  '';
}
