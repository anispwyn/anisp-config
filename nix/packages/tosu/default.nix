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
  version = "4.26.2";

  src = fetchFromGitHub {
    owner = "tosuapp";
    repo = "tosu";
    rev = "v${version}";
    hash = "sha256-ULgkSu0nbMUCfTKqporX9h9eG/U6ehhw+Ycbu7ljmto=";
  };

  lazer-calculator = callPackage ./lazer-calculator.nix {};
in
  stdenv.mkDerivation (finalAttrs: {
    inherit pname version src;

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      hash = "sha256-vIThqpIdgonOjRTT/qdcOIs+D74n66EpviD6+1MmOKc=";
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

      for dir in $(find node_modules -name "lazer-calculator-linux-x64" -type d); do
        cp -r ${lazer-calculator}/lib/lazer-calculator/* "$dir/"
      done

      # tsprocess
      pushd packages/tsprocess
      node-gyp rebuild
      pnpm run build
      popd

      pnpm run -C packages/server prepare
      pnpm run -C packages/tosu genver
      pnpm run -C packages/tosu ts:compile

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/lib/tosu"
      cp -r packages/tosu/dist/* "$out/lib/tosu/"
      mkdir -p "$out/lib"
      cp -r packages/tosu/dist/assets "$out/lib/assets"
      cp -r ${lazer-calculator}/lib/lazer-calculator/* "$out/lib/tosu/"

      # Wrap the entrypoint with node
      mkdir -p "$out/bin"
      makeWrapper "${nodejs_26}/bin/node" "$out/bin/tosu" \
        --add-flags "$out/lib/tosu/index.js" \
        --prefix LD_LIBRARY_PATH : "${lazer-calculator}/lib/lazer-calculator:$out/lib/tosu"

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
