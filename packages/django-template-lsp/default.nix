{
  python3Packages,
  fetchFromGitHub,
}:

let
  pythonPackages = python3Packages.overrideScope (
    self: super: {
      lsprotocol = self.lsprotocol_2023;
      pygls = self.pygls_1;
    }
  );
in
pythonPackages.buildPythonApplication (finalAttrs: {
  pname = "django-template-lsp";
  version = "1.3.1";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "fourdigits";
    repo = "django-template-lsp";
    tag = "${finalAttrs.version}";
    hash = "sha256-8tSKKAjKxEMeIi4goWVSlXVrlMZhS2lM/8OYSUTE5A0=";
  };

  dependencies = with pythonPackages; [
    pygls
    jedi
  ];
  build-system = with pythonPackages; [
    setuptools
    wheel
  ];
})
