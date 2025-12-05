{
  lib,
  fetchFromGitHub,
  buildDotnetModule,
  dotnetCorePackages,
  jq,
  stdenvNoCC,
}:
let
  pname = "razor-extensions";
  dotnet-sdk =
    with dotnetCorePackages;
    sdk_9_0
    // {
      inherit
        (combinePackages [
          sdk_9_0
          sdk_8_0
        ])
        packages
        targetPackages
        ;
    };
  dotnet-runtime = dotnetCorePackages.runtime_9_0;

  project = "Microsoft.VisualStudioCode.RazorExtension";
in
buildDotnetModule rec {
  inherit pname dotnet-sdk dotnet-runtime;

  vsVersion = "2.103.33-prerelease";
  src = fetchFromGitHub {
    owner = "dotnet";
    repo = "razor";
    rev = "VSCode-CSharp-${vsVersion}";
    hash = "sha256-R7ISTl4/IcmEn9twyL6LgTp0WRLWRjvXbzDT4MAO3HA=";
  };

  version = "10.0.0-preview.25577.1";
  projectFile = "src/Razor/src/${project}/${project}.csproj";
  useDotnetFromEnv = true;
  nugetDeps = ./deps.json;

  nativeBuildInputs = [ jq ];

  postPatch = ''
    # Upstream uses rollForward = latestPatch, which pins to an *exact* .NET SDK version.
    jq '.sdk.rollForward = "latestMinor"' < global.json > global.json.tmp
    mv global.json.tmp global.json
  '';

  dotnetFlags = [
    # this removes the Microsoft.WindowsDesktop.App.Ref dependency
    "-p:EnableWindowsTargeting=false"
    "-p:PublishReadyToRun=false"
  ];

  dotnetInstallFlags = [
    "-p:InformationalVersion=$version"
  ];

  passthru = {
    updateScript = ./update.sh;
  };

  meta = {
    homepage = "https://github.com/dotnet/razor";
    description = "Razor language server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      bretek
      tris203
    ];
  };
}
