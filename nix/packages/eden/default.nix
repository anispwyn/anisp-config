{
  eden,
  lib,
  fetchFromGitHub,
  fetchFromGitea,
  qt6,
  discord-rpc,
  fetchpatch,
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
      version = "0.2.0";

      src = fetchFromGitea {
        domain = "git.eden-emu.dev";
        owner = "eden-emu";
        repo = "eden";
        tag = "v${finalAttrs.version}";
        hash = "sha256-Q/tJP6AHAtW9AXn9G+8dF4oTlKDfNHN4cuTKXtYq0T8=";
      };
      patches = [
        (fetchpatch {
          # https://github.com/NixOS/nixpkgs/pull/501957/changes#diff-760737027d55be43181276d19049423c00510b9626f081a0512a86afe2368a27
          # httplib uses `SameMinorVersion` compatibility for its CMake files which
          # makes it reject the nixpkgs version which is newer
          name = "revert-httplib-version-specification.patch";
          url = "https://git.eden-emu.dev/eden-emu/eden/commit/9c13c71da8dcc37d03fc53bc3bc16978a65fd8f2.patch";
          hash = "sha256-g7q40BDb9TKE8eudBS7Smajq5EYCzxSemZgsl2ialJo=";
          revert = true;
        })
      ];
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
