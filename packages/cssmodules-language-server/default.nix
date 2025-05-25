{

  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "cssmodules-language-server";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "antonk52";
    repo = "cssmodules-language-server";
    tag = "v${finalAttrs.version}";
    hash = "sha256-MpUZn+UaelnCoyokPszc+Q566zs0BzKFAytWdRuOJ8U=";
  };
  npmDepsHash = "sha256-qvQtWMGKRU7CcAE/ozv1cr+tlDrdp+PfQrh8ouTmX2A=";

  meta = {
    description = "autocompletion and go-to-defintion for cssmodules";
    homepage = "https://github.com/antonk52/cssmodules-language-server";
    license = lib.licenses.mit;
    mainProgram = "cssmodules-language-server";
    maintainers = [ ];
  };
})
