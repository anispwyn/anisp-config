{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
  pkgs.sunshine.overrideAttrs (finalAttrs: oldAttrs: {
    pname = "apollo";
    src = pkgs.fetchFromGitHub {
      owner = "ClassicOldSong";
      repo = "Apollo";
      rev = "f253c8f";
      hash = "sha256-KLmMeCu6NGGVrHSawk2giVub7fqrjK2nT3+swuKtKEM=";
      fetchSubmodules = true;
    };
    ui = pkgs.buildNpmPackage {
      inherit (finalAttrs) src version;
      pname = "apollo-ui";
      npmDepsHash = "sha256-FNdZ2YIlbdhwt9BW/rcLOUbPYqMtDW6Pu3jLPU280jY=";

      postPatch = ''
        cp ${./deps/package-lock.json} ./package-lock.json
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"
        cp -a . "$out"/

        runHook postInstall
      '';
    };
    postPatch =
      # don't look for npm since we build webui separately
      ''
        substituteInPlace cmake/targets/common.cmake \
          --replace-fail 'find_program(NPM npm REQUIRED)' ""
      ''
      # use system boost instead of FetchContent.
      # FETCH_CONTENT_BOOST_USED prevents Simple-Web-Server from re-finding boost
      + ''
        echo 'set(FETCH_CONTENT_BOOST_USED TRUE)' >> cmake/dependencies/Boost_Sunshine.cmake
      ''
      # remove upstream dependency on systemd and udev
      + lib.optionalString isLinux ''
        substituteInPlace cmake/packaging/linux.cmake \
          --replace-fail 'find_package(Systemd)' "" \
          --replace-fail 'find_package(Udev)' ""

        substituteInPlace packaging/linux/dev.lizardbyte.app.Sunshine.desktop \
          --subst-var-by PROJECT_NAME 'Apollo' \
          --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Artemis (Moonlight Noir)' \
          --subst-var-by SUNSHINE_DESKTOP_ICON 'apollo' \
          --subst-var-by CMAKE_INSTALL_FULL_DATAROOTDIR "$out/share" \
          --replace-fail '/usr/bin/env systemctl start --u sunshine' 'sunshine'

        substituteInPlace packaging/linux/sunshine.service.in \
          --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
          --subst-var-by SUNSHINE_SERVICE_START_COMMAND 'ExecStart=$out/bin/sunshine' \
          --replace-fail '/bin/sleep' '${lib.getExe' pkgs.coreutils "sleep"}'
      '';
  })
