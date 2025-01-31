{
  stdenvNoCC,
  lib,
  bash,
  installShellFiles,
  shellcheck-minimal,
  ghostscript,
}:

stdenvNoCC.mkDerivation {
  name = "shrinkpdf";

  src = builtins.filterSource (name: _: !(lib.hasSuffix ".nix" name)) ./.;

  strictDeps = true;
  buildInputs = [
    bash
    ghostscript
  ];
  nativeBuildInputs = [ installShellFiles ];
  nativeCheckInputs = [ shellcheck-minimal ];

  postPatch = ''
    patchShebangs --host shrinkpdf
  '';

  installPhase = ''
    installBin shrinkpdf
    # installManPage nixos-firewall-tool.1
    # installShellCompletion nixos-firewall-tool.{bash,fish}
  '';

  # Skip shellcheck if GHC is not available, see writeShellApplication.
  doCheck =
    lib.meta.availableOn stdenvNoCC.buildPlatform shellcheck-minimal.compiler
    && (builtins.tryEval shellcheck-minimal.compiler.outPath).success;
  checkPhase = ''
    shellcheck shrinkpdf
  '';

  meta = with lib; {
    description = "A simple wrapper around Ghostscript to shrink PDFs";
    homepage = "https://github.com/aklomp/shrinkpdf";
    license = licenses.bsd3;
    platforms = platforms.linux;
    mainProgram = "shrinkpdf";
  };
}
