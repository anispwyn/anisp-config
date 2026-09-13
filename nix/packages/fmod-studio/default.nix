{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  addDriverRunpath,
  alsa-lib,
  dbus,
  expat,
  fontconfig,
  freetype,
  glib,
  krb5,
  libGL,
  libX11,
  libXcomposite,
  libXdamage,
  libXext,
  libXfixes,
  libXi,
  libXrandr,
  libXrender,
  libXtst,
  libdrm,
  libglvnd,
  libpulseaudio,
  libxcb,
  libxcb-cursor,
  libxcb-image,
  libxcb-keysyms,
  libxcb-render-util,
  libxcb-util,
  libxcb-wm,
  libxcursor,
  libxkbcommon,
  libxkbfile,
  libxshmfence,
  nspr,
  nss,
  wayland,
  zlib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "fmod-studio";
  version = "2.03.14";

  src = fetchurl {
    url = "https://d2m8b09s60for2.cloudfront.net/fmodstudio/tool/Linux/fmodstudio20314linux64-installer.deb?Expires=1789155792&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMm04YjA5czYwZm9yMi5jbG91ZGZyb250Lm5ldC9mbW9kc3R1ZGlvL3Rvb2wvTGludXgvZm1vZHN0dWRpbzIwMzE0bGludXg2NC1pbnN0YWxsZXIuZGViIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzg5MTU1NzkyfX19XX0_&Signature=BbLOhuQF-m2TT6yVYxdIkVrtt0gWnhAjIQM7g-Px07b0IlltVtslxfL4HO41XxWImy32cpOeBpqwqkP905nbjndaZOPVcnjlzagDECvlLp4SB9UBKCumUNgYP-AAg1~5n2JCeJozCsFS1usrqXt8b~5JwGJXZSmrHBo0rxUNZOuuu5sY5fLft42DQlBXCTZfbLyC1NMZt6V5ciYvkJI~gj16-cJpbfESEpazR1XhjhFefQ2zfpvu34FVgzcUi~G7LO-P3rhiwXBLpbhj9qmVZh20ZozaNKUbQEptQkez3MEQ7S0oBZmhgB1kw-e~Sfa2-D8eHKMNU9cwTe0i7ttFiA__&Key-Pair-Id=APKAJ4WISJ3BQB7EL4AA";
    hash = "sha256-nmqJMxQj0/ups9bGWpGDYYoXIo2MRw//t3jm1QKcTTw=";
    name = "fmodstudio20314linux64-installer.deb";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
    addDriverRunpath
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    zlib
    glib
    dbus
    fontconfig
    freetype
    libGL
    libglvnd
    alsa-lib
    libpulseaudio
    nspr
    nss
    expat
    libdrm
    krb5
    # X11
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrender
    libXrandr
    libXtst
    libXi
    libxcb
    libxshmfence
    libxkbfile
    libxcursor
    # XCB
    libxcb-cursor
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    libxcb-util
    # Wayland
    libxkbcommon
    wayland
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt
    cp -r opt/fmodstudio $out/opt/fmodstudio

    # Remove deprecated wl-shell plugin that depends on non-existent Qt6WlShellIntegration
    rm -f $out/opt/fmodstudio/Qt/wayland-shell-integration/libwl-shell-plugin.so

    mkdir -p $out/share
    cp -r usr/share/* $out/share/

    substituteInPlace $out/share/applications/fmodstudio.desktop \
      --replace-fail "/opt/fmodstudio/fmodstudio" "fmodstudio %F"

    mkdir -p $out/bin
    makeWrapper $out/opt/fmodstudio/fmodstudio $out/bin/fmodstudio \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libpulseaudio alsa-lib libGL libglvnd]}:/run/opengl-driver/lib" \
      --prefix ALSA_PLUGIN_DIR : "/run/current-system/sw/lib/alsa-lib"

    makeWrapper $out/opt/fmodstudio/fmodstudiocl $out/bin/fmodstudiocl \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libpulseaudio alsa-lib libGL libglvnd]}:/run/opengl-driver/lib" \
      --prefix ALSA_PLUGIN_DIR : "/run/current-system/sw/lib/alsa-lib"

    runHook postInstall
  '';

  postFixup = ''
    addDriverRunpath $out/opt/fmodstudio/fmodstudio
    addDriverRunpath $out/opt/fmodstudio/fmodstudiocl
    addDriverRunpath $out/opt/fmodstudio/libexec/QtWebEngineProcess
    for f in $out/opt/fmodstudio/lib/*.so*; do
      if [ -f "$f" ] && ! [ -L "$f" ]; then
        addDriverRunpath "$f"
      fi
    done
  '';

  meta = {
    description = "FMOD Studio Digital Audio Workstation for Games";
    homepage = "https://fmod.com/";
    license = lib.licenses.unfree;
    platforms = ["x86_64-linux"];
    mainProgram = "fmodstudio";
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
