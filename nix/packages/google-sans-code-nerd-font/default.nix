{
  lib,
  stdenvNoCC,
  pkgs,
}:
stdenvNoCC.mkDerivation rec {
  pname = "google-sans-code-nerd-font";
  version = "1.0.0";

  src = pkgs.fetchzip {
    url = "https://github.com/wylu1037/${pname}/releases/download/v${version}/${pname}.zip";
    hash = "sha256-jyr+vSCLx3MUyPHrtwNd7V6QYYqMKU1kvRn9M20gnbg=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 $src/*.ttf -t $out/share/fonts/truetype/google-sans-code-nerd

    runHook postInstall
  '';

  meta = {
    description = "";
    homepage = "";
    license = lib.licenses.ofl;
    maintainers = with lib.maintainers; [anispwyn];
  };
}
