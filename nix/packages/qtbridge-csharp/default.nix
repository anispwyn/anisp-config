{
  buildDotnetModule,
  dotnetCorePackages,
  qt6,
  fetchgit,
}:
buildDotnetModule (finalAttrs: {
  pname = "qtbridge-csharp";
  version = "0.4.0-beta";
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  src = fetchgit {
    url = "https://code.qt.io/qt/qtbridge-csharp.git";
    tag = finalAttrs.version;
    fetchSubmodules = true;
    hash = "sha256-5eKaU0aSDVCtNKzBu6/IdzVrkhqI4XKd1A+SNhpOS8U=";
  };

  dontWrapQtApps = true;
  nugetDeps = ./deps.json;

  projectFile = [
    "src/Qt.Bridge.CSharp.Generator/Qt.Bridge.CSharp.Generator.csproj"
    "src/Qt.Bridge.CSharp.Generator.Rules.SourceCode/Qt.Bridge.CSharp.Generator.Rules.SourceCode.csproj"
    "src/Qt.Bridge.CSharp.Generator.Rules.Metadata/Qt.Bridge.CSharp.Generator.Rules.Metadata.csproj"
  ];

  buildInputs = with qt6; [
    qtbase
    qtsvg
    qtdeclarative
    qtquick3d
    qtquick3dphysics
    qtquicktimeline
  ];

  passthru.updateScript = ./update.sh;
})
