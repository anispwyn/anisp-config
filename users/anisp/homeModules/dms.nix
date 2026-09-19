{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.desktop;
  presetName =
    if cfg.preset != null
    then cfg.preset
    else cfg.presets;
  isNiri = cfg.enable && presetName == "niri";
in {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.homeModules.default
  ];

  config = lib.mkIf isNiri {
    programs.dank-material-shell = {
      enable = true;
      managePluginSettings = true;
      plugins = {
        dankKDEConnect.enable = true;
      };
      systemd.enable = true;
      niri = {
        enableSpawn = false;
        includes = {
          enable = true;
          override = true;
          originalFileName = "hm";
          filesToInclude = ["alttab" "layout" "wpblur" "cursor"];
        };
      };
      enableSystemMonitoring = true;
      enableCalendarEvents = false;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableClipboardPaste = true;
      session = let
        wp = ../assets/Wallpapers/HLoAT6paUAA2nXU.jpg;
      in {
        wallpaperPath = wp;
        wallpaperPathLight = wp;
        wallpaperPathDark = wp;
        niriOutputSettings = {
          eDP-1 = {
            hotCorners = null;
            layout = null;
            vrrOnDemand = true;
          };
        };
        configVersion = 6;
      };
      clipboardSettings = {
        maxHistory = 1000;
        autoClearDays = 7;
      };
      settings = {
        currentThemeName = "custom";
        currentThemeCategory = "custom";
        widgetBackgroundCustomStrength = 1;
        radiusStrength = 0;
        clockFormat = "12h";
        showSeconds = true;
        padHours12Hour = true;
        blurBorderOpacity = 0;
        useAutoLocation = true;
        weatherEnabled = false;
        fontFamily = "Noto Sans";
        monoFontFamily = "Google Sans Code Nerd Font";
        textRenderQuality = 4;
        dockConfigs = [
          {
            id = "dock";
            name = "Dock";
            enabled = true;
            screenPreferences = [
              "all"
            ];
            showOnLastDisplay = true;
            position = 2;
            mode = "compact";
            taskbarAlign = "center";
            widgetExpansion = "popout";
            iconSize = 40;
            spacing = 4;
            itemSpacing = 4;
            margin = 0;
            bottomGap = 0;
            transparency = 1;
            followInterfaceStyle = true;
            autoHide = true;
            smartAutoHide = true;
            useOverlayLayer = false;
            editOnRightClick = false;
            showOnFullscreen = false;
            openOnOverview = false;
            groupByApp = false;
            separatePinnedAndRunningApps = false;
            restoreSpecialWorkspaceOnClick = false;
            isolateDisplays = false;
            indicatorStyle = "line";
            borderEnabled = false;
            borderColor = "surfaceText";
            borderOpacity = 1;
            borderThickness = 1;
            launcherEnabled = false;
            launcherLogoMode = "apps";
            launcherLogoCustomPath = "";
            launcherLogoColorOverride = "";
            launcherLogoSizeOffset = 0;
            launcherLogoBrightness = 0.5;
            launcherLogoContrast = 1;
            maxVisibleApps = 0;
            maxVisibleRunningApps = 0;
            showOverflowBadge = true;
            showTrash = false;
            trashFileManager = "default";
            trashCustomCommand = "";
            order = [];
            widgets = [
              {
                id = "dock_launcher";
                widgetId = "dockLauncher";
                enabled = true;
              }
              {
                id = "dock_apps";
                widgetId = "appsDock";
                enabled = true;
              }
              {
                id = "dock_trash";
                widgetId = "dockTrash";
                enabled = true;
              }
            ];
          }
        ];
        keyboardLayouts = "us,th";
        keyboardOptions = "grp:alt_shift_toggle";
        springBounce = 2;
        motionEffect = 2;
        barElevationEnabled = false;
        blurredWallpaperLayer = true;
        mediaLyricsProviders = [
          {
            id = "lrclib";
            enabled = true;
          }
          {
            id = "betterlyrics";
            enabled = true;
          }
          {
            id = "unison";
            enabled = true;
          }
          {
            id = "lyricsplus";
            enabled = true;
          }
        ];
        niriOverviewOverlayEnabled = false;
        spotlightBarShowModeChips = true;
        dashTabs = [
          {
            id = "overview";
            enabled = true;
          }
          {
            id = "media";
            enabled = true;
          }
          {
            id = "wallpaper";
            enabled = false;
          }
          {
            id = "weather";
            enabled = false;
          }
          {
            id = "settings";
            enabled = false;
          }
          {
            id = "notifications";
            enabled = false;
          }
        ];
        dashCards = [
          {
            id = "weather";
            w = 1;
            h = 1;
          }
          {
            id = "calendar";
            w = 3;
            h = 3;
          }
          {
            id = "user";
            w = 3;
            h = 1;
          }
          {
            id = "media";
            w = 3;
            h = 2;
          }
          {
            id = "cpu";
            w = 1;
            h = 1;
          }
          {
            id = "network";
            w = 1;
            h = 1;
          }
          {
            id = "memory";
            w = 1;
            h = 1;
          }
          {
            id = "sysmon";
            w = 1;
            h = 1;
          }
          {
            id = "disk";
            w = 1;
            h = 1;
          }
          {
            id = "clock";
            w = 1;
            h = 1;
          }
        ];
        dashOptions = {
          clock = {
            seconds = true;
          };
          overview = {
            panelColumns = 8;
          };
          media = {
            animatedArt = true;
            panelColumns = 8;
          };
        };
        cursorSettings = {
          niri = {
            hideWhenTyping = true;
          };
          size = 16;
          theme = "BreezeX-RosePineDawn-Linux";
        };
        launcherLogoMode = "os";
        launcherLogoColorOverride = "primary";
        acMonitorTimeout = 300;
        acLockTimeout = 180;
        runDmsMatugenTemplates = false;
        matugenTemplateGtk = false;
        matugenTemplateNiri = false;
        matugenTemplateHyprland = false;
        matugenTemplateMangowc = false;
        matugenTemplateQt5ct = false;
        matugenTemplateQt6ct = false;
        matugenTemplateFirefox = false;
        matugenTemplatePywalfox = false;
        matugenTemplateZenBrowser = false;
        matugenTemplateVesktop = false;
        matugenTemplateEquibop = false;
        matugenTemplateGhostty = false;
        matugenTemplateKitty = false;
        matugenTemplateFoot = false;
        matugenTemplateAlacritty = false;
        matugenTemplateWezterm = false;
        matugenTemplateDgop = false;
        matugenTemplateKcolorscheme = false;
        matugenTemplateVscode = false;
        matugenTemplateEmacs = false;
        matugenTemplateZed = false;
        matugenTemplateNeovimSetBackground = false;
        lockScreenNotificationMode = 2;
        notificationCompactMode = true;
        notificationShowTimeoutBar = true;
        osdMediaPlaybackEnabled = true;
        osdPowerProfileEnabled = true;
        osdWorkspaceEnabled = true;
        barConfigs = [
          {
            autoHide = true;
            autoHideDelay = 1000;
            autoHideStrict = false;
            borderEnabled = false;
            bottomGap = 0;
            centerWidgets = [
              {
                enabled = true;
                id = "music";
                mediaSize = 3;
              }
              {
                clockCompactMode = false;
                enabled = true;
                id = "clock";
              }
            ];
            enabled = true;
            gothCornerRadiusOverride = false;
            gothCornersEnabled = true;
            hoverPopouts = false;
            id = "default";
            innerPadding = 0;
            leftWidgets = [
              "launcherButton"
              "workspaceSwitcher"
              "focusedWindow"
            ];
            maximizeDetection = true;
            maximizeWidgetIcons = false;
            maximizeWidgetText = false;
            name = "Main Bar";
            noBackground = true;
            openOnOverview = true;
            popupGapsAuto = true;
            position = 1;
            rightWidgets = [
              {
                enabled = true;
                id = "dankKDEConnect";
              }
              {
                enabled = true;
                id = "systemTray";
                trayUseInlineExpansion = false;
              }
              {
                enabled = true;
                id = "clipboard";
              }
              {
                enabled = true;
                id = "cpuUsage";
              }
              {
                enabled = true;
                id = "memUsage";
                showSwap = false;
                showInGb = true;
              }
              {
                enabled = true;
                id = "notificationButton";
              }
              {
                enabled = true;
                id = "controlCenterButton";
                showAudioPercent = false;
                showMicIcon = false;
                showMicPercent = false;
                showBrightnessIcon = false;
                showBrightnessPercent = false;
                showBatteryIcon = false;
                showPrinterIcon = false;
                showIdleInhibitorIcon = false;
                showDoNotDisturbIcon = false;
                controlCenterGroupOrder = [
                  "network"
                  "vpn"
                  "bluetooth"
                  "audio"
                  "microphone"
                  "brightness"
                  "battery"
                  "printer"
                  "screenSharing"
                  "idleInhibitor"
                  "doNotDisturb"
                ];
              }
            ];
            scrollXBehavior = "column";
            shadowIntensity = 0;
            showOnWindowsOpen = true;
            spacing = 0;
            squareCorners = true;
            transparency = 1;
            useOverlayLayer = false;
            widgetOutlineEnabled = false;
            widgetTransparency = 1;
            followInterfaceStyle = true;
            screenPreferences = [
              "all"
            ];
            islandHomeClockDisplay = "both";
            islandHomeCompactTight = true;
            islandNotificationPopups = true;
            islandNotificationExpand = false;
            islandSatellitesEnabled = true;
            islandSatellitePosition = "edges";
            islandSatelliteBackground = false;
            islandSatelliteGothCorners = false;
            attachToScreenEdge = false;
          }
        ];
        builtInPluginSettings = {
          dms_clipboard_search = {
            trigger = "cb";
          };
          dms_power = {
            trigger = "pw";
          };
          dms_qr_generator = {
            trigger = "qrg";
          };
          dms_settings_search = {
            trigger = "?";
          };
        };
        clipboardEnterToPaste = true;
        configVersion = 28;
      };
    };
  };
}
