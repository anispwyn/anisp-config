{
  stdenvNoCC,
  autoPatchelfHook,
  lib,
  ...
}: let
  pname = "antigravity-cli";
  version = "1.0.1";

  # each src is extracted from the installer script json
  src =
    {
      x86_64-linux = fetchTarball {
        url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.1-5826024320139264/linux-x64/cli_linux_x64.tar.gz";
        sha256 = "sha256-ZAJ1b8YLSwcFVhZhJYWabdzePwnwtgGeOFhIzTxRZDc=";
      };
      aarch64-linux = fetchTarball {
        url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.0-5288553236791296/linux-arm/cli_linux_arm64.tar.gz";
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
      # aarch64-darwin = fetchTarball {
      #   url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.0-5288553236791296/darwin-arm/cli_linux_x64.tar.gz";
      #   sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      # };
      # x86_64-darwin = fetchTarball {
      #   url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.0-5288553236791296/darwin-x64/cli_mac_x64.tar.gz";
      #   hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      # };
    }.${
      stdenvNoCC.system
    } or (throw "antigravity-cli: ${stdenvNoCC.system} is unsupported.");
in
  stdenvNoCC.mkDerivation {
    inherit pname version src;
    dontUnpack = true;

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      # in their install script they call it this, unsure if we wanna use this too
      cp $src $out/bin/agy

      runHook postInstall
    '';

    meta = {
      mainProgram = "agy";
      description = "The lightweight, fast, terminal-first surface to work with Antigravity agents. Run autonomous coding agents, execute shell commands directly, and manage background subagents all from your keyboard.";
      homepage = "https://antigravity.google";
      downloadPage = "https://antigravity.google/download";
      changelog = "https://antigravity.google/changelog";
      license = lib.licenses.unfree;
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      maintainers = with lib.maintainers; [anispwyn];
    };
  }
