{
  rustPlatform,
  fetchFromGitHub,
  python3,
  ensureNewerSourcesForZipFilesHook,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "django-language-server";
  version = "6.0.3";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "joshuadavidthomas";
    repo = "django-language-server";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WQRAVwgkT5E7daHMTd4nSfMqbULMcUI2tIlXNgRlOsc=";
  };

  cargoBuildFlags = [ "--package=djls" ];
  cargoHash = "sha256-EjGHTOvYricjUhWB5GxGXxZK7TYnFbEvEyi1kER+JA4=";

  # Tests require additional setup and data files
  doCheck = false;

  nativeBuildInputs = [
    ensureNewerSourcesForZipFilesHook
    python3
  ];
})
