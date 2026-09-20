{
  lib,
  chatterino2,
  fetchFromGitHub,
  nix-update-script,
}:
(chatterino2.buildChatterino {
  enableAvifSupport = true;
}).overrideAttrs
(
  finalAttrs: _: {
    pname = "moltorino";
    version = "nightly-build-unstable-2026-10-14";

    src = let
      commit = "cacc38823254b93ba335e7b10739679471ffeb2b";
    in
      fetchFromGitHub {
        owner = "SevenTV";
        repo = "chatterino7";
        rev = commit;
        hash = "sha256-ob/l1HMiwFXO8VoIx1vnVi7agU0bS0lgI9j2SC/aiWA=";
        fetchSubmodules = true;
        leaveDotGit = true;
        postFetch = ''
          git -C $out rev-parse --short HEAD > $out/GIT_HASH
          find "$out" -name .git -print0 | xargs -0 rm -rf
        '';
      };

    passthru.updateScript = nix-update-script {
      extraArgs = [
        "--flake"
        "--version=branch=chatterino7"
      ];
    };

    meta = {
      description = "Chat client for Twitch chat";
      mainProgram = "chatterino";
      longDescription = ''
        Chatterino is a chat client for Twitch chat. It aims to be an
        improved/extended version of the Twitch web chat. Chatterino 7 is
        a fork of Chatterino 2, which contains additional 7TV features
        not found in Chatterino 2.
      '';
      homepage = "https://github.com/SevenTV/chatterino7";
      changelog = "https://github.com/SevenTV/chatterino7/blob/${finalAttrs.src.rev}/CHANGELOG.c7.md";
      license = lib.licenses.mit;
      platforms = lib.platforms.unix;
      maintainers = with lib.maintainers; [
        marie
        supa
      ];
    };
  }
)
