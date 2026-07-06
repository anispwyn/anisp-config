{
  buildDotnetModule,
  dotnetCorePackages,
  qt6,
}:
buildDotnetModule (finalAttrs: {
  pname = "qtbridge-csharp";
  version = "0.3.0-beta";
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  src = fetchGit {
    url = "https://code.qt.io/qt/qtbridge-csharp.git";
    submodules = true;
    rev = "81e231cc8741a553be1056c0feebbb98a9c10298";
  };

  dontWrapQtApps = true;
  nugetDeps = ./deps.json;

  projectFile = [
    "src/Qt.Bridge.CSharp.Generator/Qt.Bridge.CSharp.Generator.csproj"
    "src/Qt.Bridge.CSharp.GenerationRules/Qt.Bridge.CSharp.GenerationRules.csproj"
  ];

  buildInputs = with qt6; [
    qtbase
    qtsvg
    qtdeclarative
    qtquick3d
    qtquick3dphysics
    qtquicktimeline
  ];
})
