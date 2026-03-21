final: prev: {
  roslyn-ls = prev.stdenv.mkDerivation rec {
    pname = "roslyn-ls";
    version = "5.4.0-2.26168.13";

    src = prev.fetchzip {
      url = "https://github.com/Crashdummyy/roslynLanguageServer/releases/download/${version}/microsoft.codeanalysis.languageserver.linux-x64.zip";
      hash = "sha256-83AeNQjzL/luSBcxwtzJc4C1R0fYeBpTiJSQAhB250g=";
      stripRoot = false;
    };

    nativeBuildInputs = [
      prev.makeWrapper
    ];

    dontBuild = true;
    dontConfigure = true;
    dontPatch = true;
    dontFixup = true;

    dontUnpack = true;

    installPhase = ''
            mkdir -p $out/lib/roslyn $out/bin

            cp -r "$src/." $out/lib/roslyn/

            # Fix permissions on native libs
            find $out/lib/roslyn -type f -name "*.so" -exec chmod +x {} \; 2>/dev/null || true

            makeWrapper ${final.dotnet-sdk_10}/bin/dotnet $out/bin/roslyn \
      --add-flags "exec" \
          --add-flags "$out/lib/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll" \
          --add-flags "--razorSourceGenerator $out/lib/roslyn/.razorExtension/Microsoft.CodeAnalysis.Razor.Compiler.dll" \
          --add-flags "--razorDesignTimePath $out/lib/roslyn/.razorExtension/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets" \
          --add-flags "--extension $out/lib/roslyn/.razorExtension/Microsoft.VisualStudioCode.RazorExtension.dll" \
              --set DOTNET_ROOT ${final.dotnet-sdk_10}

            # Also create roslyn-ls symlink for compatibility
            ln -s $out/bin/roslyn $out/bin/roslyn-ls
    '';

    meta = {
      description = "Roslyn language server with Razor cohosting (.NET 10)";
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
  };
}
