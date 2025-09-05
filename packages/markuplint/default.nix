{
  lib,
  fetchurl,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  pname = "markuplint";
  version = "4.13.1";

  src = fetchurl {
    url = "https://registry.npmjs.org/markuplint/-/markuplint-${finalAttrs.version}.tgz";
    hash = "sha256-hBkfRrQ7rpPCUbJE1ADnTvkVQieFhoG4oKx+cs/ax3w=";
  };
  npmDepsHash = "sha256-iod5htXEzIbfSxmQYwzLut5/vmog1jwVTWCYAX7vVTc=";

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
