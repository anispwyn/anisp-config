{
  stdenv,
  fetchFromGitHub,
  vlang,
  lib,
  writableTmpDirAsHomeHook,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "velvet";
  version = "0.5.8";

  src = fetchFromGitHub {
    owner = "DaZhi-the-Revelator";
    repo = "velvet";
    rev = "v${finalAttrs.version}";
    hash = "sha256-yiBcIXf2omJul3uLwwK//g32EZfg/uojSFOYr+p+FuI=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    vlang
    writableTmpDirAsHomeHook
  ];

  postPatch = ''
    substituteInPlace build.vsh \
      --replace-fail "os.exists('/etc/NIXOS')" "true"
  '';

  installPhase = ''
    mkdir -p $out/bin
    v run build.vsh release
    install -Dm755 ./bin/velvet $out/bin/velvet
  '';

  meta = {
    mainProgram = "velvet";
    description = "V Enhanced Language and Tooling - an LSP for the V Language ";
    homepage = "https://github.com/DaZhi-the-Revelator/velvet";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [anispwyn];
  };
})
