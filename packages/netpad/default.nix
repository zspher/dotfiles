# {
#   stdenv,
#   lib,
#   fetchurl,
#   dpkg,
#   autoPatchelfHook,
#   glib,
#   gtk3,
#   webkitgtk_4_1,
#   lttng-ust_2_12,
#   makeWrapper,
#   dotnetCorePackages,
#   icu,
#   openssl,
#   dotnet-ef,
#   glib-networking,
# }:
#
# stdenv.mkDerivation rec {
#   pname = "netpad";
#   version = "0.11.0";
#
#   src = fetchurl {
#     # url = "https://github.com/tareqimbasher/NetPad/releases/download/v${version}/netpad_vnext-${version}-linux-amd64.deb";
#     # hash = "sha256-cBUDIqvnSbEmfSMtz1LEut1O3fy1Uyp8P8+UyScMDag=";
#
#     url = "https://github.com/zspher/NetPad/releases/download/app-v/NetPad.vNext_0.11.0_amd64.deb";
#     hash = "sha256-Irnavzqcm4D6qzw8L983HEZjTbkZaTn93lQVLlPPypE=";
#   };
#
#   nativeBuildInputs = [
#     autoPatchelfHook
#     dpkg
#     makeWrapper
#   ];
#
#   buildInputs = [
#     glib-networking
#     webkitgtk_4_1
#     lttng-ust_2_12
#     icu
#     openssl
#
#     dotnet-ef
#   ];
#
#   sourceRoot = ".";
#
#   unpackCmd = ''
#     dpkg-deb -x $curSrc .
#   '';
#
#   dontConfigure = true;
#   dontBuild = true;
#
#   preFixup = ''
#     stripExclude=(\*.dll)
#
#     patchelf \
#       --add-needed libssl.so \
#       "$out/lib/NetPad vNext/resources/netpad-server/libSystem.Security.Cryptography.Native.OpenSsl.so"
#   '';
#
#   postFixup = ''
#     patchelf \
#       --add-needed libicui18n.so \
#       --add-needed libicuuc.so \
#       "$out/lib/NetPad vNext/resources/netpad-server/libcoreclr.so" \
#       '$out/lib/NetPad vNext/resources/netpad-server/'*System.Globalization.Native.so
#   '';
#
#   installPhase = ''
#     runHook preInstall
#
#     mkdir -p $out
#     cp -R usr/* "$out/"
#
#     rm "$out/lib/NetPad vNext/resources/netpad-server/ScriptHost/netpad-script-host.deps.json"
#
#     install -Dm 755 \
#       "usr/lib/NetPad vNext/resources/netpad-server/ScriptHost/netpad-script-host.deps.json" \
#       "$out/lib/NetPad vNext/resources/netpad-server/ScriptHost/netpad-script-host.deps.json"
#
#
#     wrapProgram $out/bin/netpad-vnext --set DOTNET_ROOT ${dotnetCorePackages.sdk_10_0-source}/share/dotnet
#
#     runHook postInstall
#   '';
#
#   meta = {
#     description = "";
#     homepage = "";
#     platforms = lib.platforms.linux;
#     mainProgram = "netpad-vnext";
#     sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
#   };
# }

{
  appimageTools,
  fetchurl,
  makeDesktopItem,
}:
let
  version = "0.11.0";
  pname = "netpad";

  src = fetchurl {
    # url = "https://github.com/tareqimbasher/NetPad/releases/download/v${version}/netpad-${version}-linux-x86_64.AppImage";
    # hash = "sha256-57EfEjsEV2OYRxt6q7yXgm2WHIQlpgkjMPSJDXiG/iQ=";
    url = "https://github.com/zspher/NetPad/releases/download/app-v/netpad-0.11.0-linux-x86_64.AppImage";
    hash = "sha256-H6mfWXxqEkDiZls5rX1meNhyPxqGFgOk3rvQUVGk97U=";
  };
  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = pname;
    exec = pname;
    comment = "Cross-platform C# editor and playground ";
    icon = "netpad";
    type = "Application";
    categories = [
      "Development"
      "IDE"
    ];
    startupWMClass = "netpad";
    startupNotify = true;
    mimeTypes = [ "application/x-netpad" ];
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: [
    pkgs.icu
    (
      with pkgs.dotnetCorePackages;
      combinePackages [
        sdk_10_0
        sdk_9_0
        sdk_8_0
      ]
    )
  ];
  extraInstallCommands = ''
    mkdir -p $out/share
    cp -rt $out/share ${desktopItem}/share/applications ${appimageContents}/usr/share/icons
    chmod -R +w $out/share
  '';
}

# {
#   rustPlatform,
#   fetchFromGitHub,
#   cargo-tauri,
#   nodejs_22,
#   npmHooks,
#   pkg-config,
#   fetchNpmDeps,
#   glib-networking,
#   openssl,
#   webkitgtk_4_1,
#   lib,
#   stdenv,
#   dotnetCorePackages,
#   buildDotnetModule,
#   stdenvNoCC,
#   jq,
#   moreutils,
# }:
# let
#   pname = "netpad";
#   version = "0.11.0";
#   src = fetchFromGitHub {
#     owner = "tareqimbasher";
#     repo = "NetPad";
#     tag = "v${version}";
#     hash = "sha256-qIR2PZRcdqTa5cmlnLJbnXyl07GNf9mHGYp1rT7I7LU=";
#   };
#
#   inherit (dotnetCorePackages) systemToDotnetRid;
#   dotnetSdk = dotnetCorePackages.sdk_9_0;
#   dotnetRuntime = dotnetCorePackages.runtime_9_0;
#   rid = dotnetCorePackages.systemToDotnetRid stdenvNoCC.hostPlatform.system;
# in
#
# rustPlatform.buildRustPackage (finalAttrs: {
#   inherit pname version src;
#
#   cargoHash = "sha256-b0nF4ZHiwJmDPrbgyOTPz443ALUGR9AOnclOf1qzMCY=";
#   npmDeps = fetchNpmDeps {
#     inherit src;
#     sourceRoot = "${src.name}/src/Apps/NetPad.Apps.App/App";
#     hash = "sha256-JSb1M8fXsmVgYnqV8LtjsY3D3zjTZqFroMA1icoYfUQ=";
#   };
#   npmRoot = "src/Apps/NetPad.Apps.App/App";
#
#   nativeBuildInputs = [
#     cargo-tauri.hook
#     dotnetSdk
#     nodejs_22
#     npmHooks.npmConfigHook
#     pkg-config
#     jq
#     moreutils
#   ];
#
#   backend = buildDotnetModule {
#     inherit pname version src;
#
#     dotnet-sdk = dotnetSdk;
#     dotnet-runtime = dotnetRuntime;
#     nativeBuildInputs = [
#       nodejs_22
#       npmHooks.npmConfigHook
#     ];
#
#     npmDeps = fetchNpmDeps {
#       inherit src;
#       sourceRoot = "${src.name}/src/Apps/NetPad.Apps.App/App";
#       hash = "sha256-JSb1M8fXsmVgYnqV8LtjsY3D3zjTZqFroMA1icoYfUQ=";
#     };
#     npmRoot = "src/Apps/NetPad.Apps.App/App";
#
#     # projectFile = "src/NetPad.sln";
#     projectFile = "src/Apps/NetPad.Apps.App/NetPad.Apps.App.csproj";
#     dotnetBuildFlags = [
#       "-p:RuntimeIdentifier=${rid}"
#       "-p:PublishReadyToRun=true"
#       "-p:PublishSingleFile=false"
#       "-p:WebBuild=true"
#     ];
#
#     env = {
#       ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
#     };
#     nugetDeps = ./deps.json;
#     selfContainedBuild = true;
#
#     preConfigure = ''
#       dotnet restore "src/NetPad.sln" \
#         --runtime ${rid} \
#         -p:ContinuousIntegrationBuild=true \
#         -p:Deterministic=true
#     '';
#
#   };
#   buildInputs =
#     lib.optionals stdenv.hostPlatform.isLinux [
#       glib-networking # Most Tauri apps need networking
#       openssl
#       webkitgtk_4_1
#     ]
#     ++ dotnetSdk.packages
#     ++ finalAttrs.backend.nugetDeps;
#
#   postPatch = ''
#     tauriConfRelease="src/Apps/NetPad.Apps.Shells.Tauri/TauriApp/src-tauri/tauri.conf.linux-x64.json5"
#     jq 'del(.build.beforeBuildCommand, .bundle.targets)' "$tauriConfRelease" | sponge "$tauriConfRelease"
#   '';
#
#   preConfigure = ''
#     dotnet restore "src/NetPad.sln" \
#       --runtime ${rid} \
#       -p:ContinuousIntegrationBuild=true \
#       -p:Deterministic=true
#
#      mkdir -p "src/Apps/NetPad.Apps.App/bin/tauri"
#      cp -R ${finalAttrs.backend}/lib/ "src/Apps/NetPad.Apps.App/bin/tauri/linux-x64"
#   '';
#   tauriBuildFlags = "-c tauri.conf.linux-x64.json5";
#
#   postInstall = ''
#     mkdir -p "$out/bin/resources/netpad-server"
#     ln -s "$out/lib/NetPad vNext/resources/netpad-server/netpad" "$out/bin/resources/netpad-server/NetPad.Apps.App"
#   '';
#
#   # Needed, otherwise you will get an error:
#   # RequestError: getaddrinfo EAI_AGAIN github.com
#   env = {
#     ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
#   };
#   cargoRoot = "src/Apps/NetPad.Apps.Shells.Tauri/TauriApp/src-tauri";
#   buildAndTestSubdir = finalAttrs.cargoRoot;
#   passthru = {
#     inherit (finalAttrs.backend) fetch-deps;
#   };
# })
