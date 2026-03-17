{ buildDotnetGlobalTool, lib }:
buildDotnetGlobalTool {
  pname = "sqlpackage";
  version = "170.3.93";

  nugetName = "Microsoft.SqlPackage";
  nugetHash = "sha256-1VcD54B+OsXXaHG+6J23+Wj316fEinQTd6TwqPZqCso=";

  meta = {
    description = "a cross-platform command-line utility for creating and deploying .dacpac and .bacpac packages";
    homepage = "https://github.com/microsoft/DacFx";
    changelog = "https://github.com/microsoft/DacFx/tree/main/release-notes/Microsoft.SqlPackage";
    license = lib.licenses.mit;
    mainProgram = "sqlpackage";
  };
}
