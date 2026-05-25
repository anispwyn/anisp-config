{
  eden,
  lib,
  fetchFromGitHub,
  fetchFromGitea,
  qt6,
  discord-rpc,
}: (
  eden.overrideAttrs (
    finalAttrs: oldAttrs: let
      edendiscordsrc = fetchFromGitHub {
        owner = "eden-emulator";
        repo = "discord-rpc";
        rev = "0d8b2d6a37";
        hash = "sha256-bsVW2yKgTyIPDyVLKYHxlllLhcY9H5B81+23zJLBIBY=";
      };
    in {
      version = "0.2.0-rc2";

      src = fetchFromGitea {
        domain = "git.eden-emu.dev";
        owner = "eden-emu";
        repo = "eden";
        tag = "v${finalAttrs.version}";
        hash = "sha256-keLkB5qeQch+tM2J6zVh9oQGhP5TuxItqrZRN24apJw=";
      };
      patches = [];
      buildInputs =
        oldAttrs.buildInputs
        ++ [
          qt6.qtcharts
          (discord-rpc.overrideAttrs {
            version = "3.4.1";
            src = edendiscordsrc;
            postPatch = '''';
          })
        ];
      cmakeFlags =
        oldAttrs.cmakeFlags
        ++ [
          (lib.cmakeBool "USE_DISCORD_PRESENCE" true)
        ];
    }
  )
)
