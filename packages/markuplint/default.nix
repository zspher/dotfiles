{
  lib,
  fetchurl,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  pname = "markuplint";
  version = "4.12.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/markuplint/-/markuplint-${finalAttrs.version}.tgz";
    hash = "sha256-mt6qjKf5GoybYTkAduXNbuPxzpbzwyOiLoH0QJh/tyo=";
  };
  npmDepsHash = "sha256-1w7WlVoDtE4rMrVWHs7gNAv2BwdNGYLd/hV7z8wPyyE=";

  postPatch = ''
    ln -s ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  meta = {
    description = "Static code analysis tool for HTML";
    homepage = "https://markuplint.dev";
    license = lib.licenses.mit;
    mainProgram = "markuplint";
    maintainers = [ ];
  };
})
