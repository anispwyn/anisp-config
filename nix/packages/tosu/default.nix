{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs_26,
  pnpm_11,
  fetchPnpmDeps,
  pnpmConfigHook,
  python3,
  node-gyp,
  makeWrapper,
  callPackage,
}: let
  pname = "tosu";
  version = "4.22.1";

  src = fetchFromGitHub {
    owner = "tosuapp";
    repo = "tosu";
    rev = "v${version}";
    hash = "sha256-Wkzj+ODHQarUks6pBXeo3NV1iVqHEBh8ngAW0+MXYvs=";
  };

  lazer-calculator = callPackage ./lazer-calculator.nix {};
in
  stdenv.mkDerivation (finalAttrs: {
    inherit pname version src;

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      hash = "sha256-2vzUyrKttt9X9LpKukumtY4EJydS2/C6hXShRq/66oA=";
      fetcherVersion = 4;
    };

    nativeBuildInputs = [
      nodejs_26
      pnpm_11
      pnpmConfigHook
      python3
      node-gyp
      makeWrapper
    ];

    CXXFLAGS = "-Wno-format-security -Wno-error=format-security";
    CFLAGS = "-Wno-format-security -Wno-error=format-security";

    buildPhase = ''
      runHook preBuild

      # devdeps
      pnpm install --frozen-lockfile --offline --ignore-scripts

      LAZER_CALC_DIR=$(find node_modules/.pnpm -name "@tosuapp+lazer-calculator*" -type d | head -n 1)/node_modules/@tosuapp/lazer-calculator
      mkdir -p "$LAZER_CALC_DIR/native/dist"
      cp -r ${lazer-calculator}/lib/lazer-calculator/* "$LAZER_CALC_DIR/native/dist/"

      # tsprocess
      pushd packages/tsprocess
      node-gyp rebuild
      pnpm run build
      popd

      pnpm run -C packages/tosu genver
      pnpm run -C packages/tosu ts:compile
      pnpm run -C packages/server prepare
      pnpm run -C packages/tosu compile:prepare-htmls

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/lib/tosu"
      cp -r packages/tosu/dist/* "$out/lib/tosu/"
      mkdir -p "$out/lib"
      cp -r packages/tosu/dist/assets "$out/lib/assets"

      # Wrap the entrypoint with node
      mkdir -p "$out/bin"
      makeWrapper "${nodejs_26}/bin/node" "$out/bin/tosu" \
        --add-flags "$out/lib/tosu/index.js" \
        --prefix LD_LIBRARY_PATH : "$out/lib/tosu/native/dist"

      runHook postInstall
    '';

    meta = {
      description = "High-performance memory reader and data provider for the rhythm game osu!";
      homepage = "https://github.com/tosuapp/tosu";
      license = lib.licenses.lgpl3Only;
      maintainers = ["anispwyn"];
      mainProgram = "tosu";
    };
  })
