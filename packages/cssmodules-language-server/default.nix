{

  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "cssmodules-language-server";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "antonk52";
    repo = "cssmodules-language-server";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9RZNXdmBP4OK7k/0LuuvqxYGG2fESYTCFNCkAWZQapk=";
  };
  npmDepsHash = "sha256-1CnCgut0Knf97+YHVJGUZqnRId/BwHw+jH1YPIrDPCA=";

  meta = {
    description = "autocompletion and go-to-defintion for cssmodules";
    homepage = "https://github.com/antonk52/cssmodules-language-server";
    license = lib.licenses.mit;
    mainProgram = "cssmodules-language-server";
    maintainers = [ ];
  };
})
