{
  lib,
  pkgs,
}:
pkgs.python3Packages.buildPythonApplication {
  pname = "omen-fan";
  version = "1";

  src = pkgs.fetchFromGitHub {
    owner = "alou-s";
    repo = "omen-fan";
    rev = "dc2aa13fb6a046766b50d60a24d3f1ef6a7b422b";
    sha256 = "sha256-9Y2JnzYX6Zfn8uUmuVwJy87gptVIL02lVMTHTRS/y8g=";
  };

  pyproject = false;
  doCheck = false;

  propagatedBuildInputs = with pkgs.python3Packages; [
    click
    click-aliases
    tomlkit
  ];

  installPhase = ''
    install -Dm755 omen-fan.py  $out/bin/omen-fan
    install -Dm755 omen-fand.py $out/bin/omen-fand
  '';

  meta = {
    description = "A script to control a certain laptop brand";
    homepage = "https://github.com/alou-s/omen-fan";
    license = lib.licenses.gpl3;
  };
}
