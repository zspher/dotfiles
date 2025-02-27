{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
  rust-jemalloc-sys,
  nix-update-script,
  versionCheckHook,
}:
rustPlatform.buildRustPackage rec {
  pname = "sqruff";
  version = "0.25.9";

  src = fetchFromGitHub {
    owner = "quarylabs";
    repo = "sqruff";
    tag = "v${version}";
    hash = "sha256-R9ZEfLBBstQtNtMkyNAdxbyhXCOJzpeFXDTb9bCaVW0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-ouDWRDIWtaITw6cJzODSMYnSEhuwW8JkslR8gia1T9o=";

  buildInputs = [
    rust-jemalloc-sys
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [ darwin.apple_sdk.frameworks.CoreServices ];

  # Patch the tests to find the binary
  postPatch = ''
    substituteInPlace \
    crates/cli/tests/fix_parse_errors.rs \
    crates/cli/tests/config_not_found.rs \
    crates/cli/tests/fix_return_code.rs \
    crates/cli/tests/configure_rule.rs \
    crates/cli/tests/ui_github.rs \
    crates/cli/tests/ui_json.rs \
    crates/cli/tests/ui.rs \
    --replace-fail \
      'sqruff_path.push(format!("../../target/{}/sqruff", profile));' \
      'sqruff_path.push(format!("../../target/${stdenv.hostPlatform.rust.cargoShortTarget}/{}/sqruff", profile));'
  '';

  doCheck = false;
  nativeCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = [ "--version" ];
  cargoTestFlags = [
    "--skip=ui_with_dbt"
  ];
  doInstallCheck = true;

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Fast SQL formatter/linter";
    homepage = "https://github.com/quarylabs/sqruff";
    changelog = "https://github.com/quarylabs/sqruff/releases/tag/${version}";
    license = lib.licenses.asl20;
    mainProgram = "sqruff";
    maintainers = with lib.maintainers; [ hasnep ];
  };
}
