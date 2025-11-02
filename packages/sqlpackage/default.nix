{ buildDotnetGlobalTool, lib }:
buildDotnetGlobalTool {
  pname = "sqlpackage";
  version = "170.3.26-preview";

  nugetName = "Microsoft.SqlPackage";
  nugetHash = "sha256-g734K2sjPL1lLJa/SKgzk1GPf1b1zQnI2NNKkMM5yNo=";

  meta = {
    description = "a cross-platform command-line utility for creating and deploying .dacpac and .bacpac packages";
    homepage = "https://github.com/microsoft/DacFx";
    changelog = "https://github.com/microsoft/DacFx/tree/main/release-notes/Microsoft.SqlPackage";
    license = lib.licenses.mit;
    mainProgram = "sqlpackage";
  };
}
