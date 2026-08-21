{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oniri";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "Antiz96";
    repo = "oniri";
    tag = "v${finalAttrs.version}";
    hash = "sha256-SXHcCM0p1QgM/M785dVYkB5PnBpbhXNzNUorAZMfQj0=";
  };

  cargoHash = "sha256-hmTwxW3/XgmF1CejErx+84oHcZ/ZVgxMysyISx0FUa8=";

  meta = {
    description = "A tool that automatically maximizes the only window of a niri workspace.";
    homepage = "https://github.com/Antiz96/oniri";
    license = lib.licenses.gpl3;
    maintainers = ["anispwyn"];
  };
})
