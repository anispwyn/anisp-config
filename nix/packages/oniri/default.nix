{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oniri";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Antiz96";
    repo = "oniri";
    tag = "v${finalAttrs.version}";
    hash = "sha256-54OA+N2qCbtfbYAEh18D1rUjxvmarZHPaH33maQa4uc=";
  };

  cargoHash = "sha256-k1hnveoLOld7ec/FRmdUt8Ayoz45FO1KBkKVlA8E/ss=";

  meta = {
    description = "A tool that automatically maximizes the only window of a niri workspace.";
    homepage = "https://github.com/Antiz96/oniri";
    license = lib.licenses.gpl3;
    maintainers = ["anispwyn"];
  };
})
