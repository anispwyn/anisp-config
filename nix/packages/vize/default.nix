{
  lib,
  makeWrapper,
  rustPlatform,
  fetchFromGitHub,
  typescript-go,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "vize";
  version = "0.39.0";
  src = fetchFromGitHub {
    owner = "ubugeeei";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-PhRKhmtF0w/wVRIS9gg4vCPow/S8KRKfiXoXwY5njKI=";
  };
  cargoHash = "sha256-AWdyFS7CquXlIAKHyWOPxNnRTHADEJLEYg2TaQ4Udek=";
  doCheck = false;

  nativeBuildInputs = [
    makeWrapper
  ];

  postInstall = ''
    rm $out/bin/coverage
    rm $out/bin/dump_patches

    wrapProgram $out/bin/vize \
    --set TSGO_PATH ${typescript-go}/bin/tsgo
  '';

  meta = {
    description = "Unofficial High-Performance Vue.js Toolchain in Rust";
    homepage = "https://github.com/ubugeeei/vize";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [anispwyn];
  };
})
