{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oniri";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "Antiz96";
    repo = "oniri";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ezSyNY21NgeR067E7tmw29SazBUt+hYpsPavOpPt3L4=";
  };

  cargoHash = "sha256-ue08WszHwDbnXRR3lxcwCrtC2XMpg55BXcj65tS3u1E=";

  meta = {
    description = "A tool that automatically maximizes the only window of a niri workspace.";
    homepage = "https://github.com/Antiz96/oniri";
    license = lib.licenses.gpl3;
    maintainers = ["anispwyn"];
  };
})
