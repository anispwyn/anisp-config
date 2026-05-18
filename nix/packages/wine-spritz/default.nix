{
  lib,
  pkgs,
}: let
  version = "11.8";
  patchesSrc = pkgs.fetchFromGitHub {
    owner = "NelloKudo";
    repo = "spritz-wine-aur";
    rev = "spritz-wine-tkg-${version}-1";
    hash = "sha256-u6RHjk6nQwv8RNyXUB9zRDGkAmx/EEIPWuh99jdjuTY=";
  };
  patchesFiles =
    builtins.sort (a: b: (toString a) < (toString b))
    (builtins.filter
      (path: lib.hasSuffix ".patch" (toString path))
      (lib.filesystem.listFilesRecursive patchesSrc));
in
  pkgs.wine64Packages.stagingFull.overrideAttrs (old: {
    patches = old.patches ++ patchesFiles;
    prePatch =
      (old.prePatch or "")
      + ''
        chmod -R +w patches
      '';
    postPatch =
      (old.postPatch or "")
      + ''
        ./tools/make_requests
        autoreconf -f
      '';
  })
