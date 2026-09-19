{
  buildDotnetModule,
  fetchFromGitHub,
  dotnet-sdk_10,
  clang,
}: let
  osuSrc = fetchFromGitHub {
    owner = "ppy";
    repo = "osu";
    rev = "fe30ae7eea2beeb1f0d3a5ce8dde12bb78ca3f48";
    hash = "sha256-SX6xmIaxiwal/NQTpMGCsoiANtUQC6qyX0ddgeUi+0g=";
  };
in
  buildDotnetModule (finalAttrs: {
    pname = "lazer-calculator";
    version = "0.6.1-20260729-main.0";

    src = fetchFromGitHub {
      owner = "tosuapp";
      repo = "lazer-calculator";
      rev = "v${finalAttrs.version}";
      hash = "sha256-OGsqZ2V7R4K8VsUqMJ8/rMEhNXzJVz4yBaibTHU5CJU=";
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
