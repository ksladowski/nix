{
  system ? builtins.currentSystem,
}:
let
  pkgs = import <nixpkgs> {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (import ../../overlays/roslyn-ls.nix)
    ];
  };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    dotnet-sdk_10
    dotnet-runtime_10
    dotnet-aspnetcore_10
    # roslyn-ls
    dotnet-ef
    csharpier
    netcoredbg
  ];

  shellHook = ''
    export DOTNET_ROOT="${pkgs.dotnet-sdk_10}/share/dotnet/"

    export ROSLYN_LSP_PATH="${pkgs.roslyn-ls}/lib/roslyn-ls";
    export ROSLYN_DLL_PATH="${pkgs.roslyn-ls}/lib/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll";
    export ROSLYN_RAZOR_PATH="${pkgs.roslyn-ls}/lib/roslyn-ls/.razorExtensions";

    export DOTNET_ENVIRONMENT=Development

    export DOTNET_CLI_TELEMETRY_OPTOUT=1

    export DOTNET_CLI_HOME="/tmp/dotnet-cli-home"
    mkdir -p $DOTNET_CLI_HOME
    chmod 755 $DOTNET_CLI_HOME

    export PATH=$PATH:$DOTNET_CLI_HOME/.dotnet/tools 

    export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    echo "Welcome to .NET $(dotnet --version) development environment!"
    echo "dotnet SDK version: $(dotnet --version)"
  '';
}
