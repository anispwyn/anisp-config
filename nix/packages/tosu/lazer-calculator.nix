{
  buildDotnetModule,
  fetchFromGitHub,
  dotnet-sdk_10,
  clang,
}: let
  osuSrc = fetchFromGitHub {
    owner = "ppy";
    repo = "osu";
    rev = "6ccef8736c8eca923885be52818d1ab367145fd8";
    hash = "sha256-HuIthP1nJvQ0+BzsoQDv88IYk3TFd3J916AbkymITIU=";
  };
in
  buildDotnetModule (finalAttrs: {
    pname = "lazer-calculator";
    version = "0.2.0-20260530.0";

    src = fetchFromGitHub {
      owner = "tosuapp";
      repo = "lazer-calculator";
      rev = "v${finalAttrs.version}";
      hash = "sha256-OImrh/NTIPonC2SMOjshoIMmMAiCsEeJm/XZVPwhD54=";
    };

    sourceRoot = "source/lib";

    dotnet-sdk = dotnet-sdk_10;

    projectFile = "native/binding.csproj";

    nugetDeps = ./nuget-deps.json;

    prePatch = ''
      mkdir -p vendor
      cp -r ${osuSrc}/* vendor/
      chmod -R +w vendor
      find vendor -name "*.cs" -exec sed -i 's/\r$//' {} +
      patch -p1 -d vendor < patches/0001-Gradual-diff-calculator.patch
    '';

    nativeBuildInputs = [clang];

    selfContainedBuild = true;
    executables = [];
  })
