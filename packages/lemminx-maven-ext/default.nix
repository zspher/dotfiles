{
  lib,
  maven,
  fetchFromGitHub,
  makeWrapper,
  jre_minimal,
  jdk17_headless,
  jdk_headless,
  unzip,
  lemminx,
}:
let
  jre = jre_minimal.override {
    modules = [
      "java.base"
      "java.logging"
      "java.xml"
      "jdk.crypto.ec"
    ];
    jdk = jdk_headless;
  };
in
maven.buildMavenPackage (finalAttrs: {
  pname = "lemminx-maven";
  version = "0.12.0";
  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "eclipse-lemminx";
    repo = "lemminx-maven";
    tag = "${finalAttrs.version}";
    hash = "sha256-8GqNVOU58LKlQxIrXaeFtKllVSv5RpqHynZCjBKEl9o=";
  };

  mvnHash = "sha256-whRbzFqCF2GsjGQoZ7cuhVn2x7F7f9Fq709oFkNsivU=";
  mvnJdk = jdk17_headless;
  mvnGoal = "verify";
  doCheck = false;

  nativeBuildInputs = [
    makeWrapper
    unzip
    lemminx
  ];

  buildInputs = [
    jre
  ];

  mvnParameters = lib.escapeShellArgs [
    "-Pgenerate-vscode-jars"
    "-Dinvoker.skip=true"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    unzip -q lemminx-maven/target/lemminx-maven-*-zip-with-dependencies.zip -d $out/share
    cp ${lemminx}/share/*.jar $out/share

    makeWrapper ${jre}/bin/java $out/bin/lemminx \
      --add-flags "-cp '$out/share/*' org.eclipse.lemminx.XMLServerLauncher"

    runHook postInstall
  '';
})
