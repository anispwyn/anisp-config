{
  inputs,
  src,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.modules.default
  ];
  programs.dank-material-shell = {
    enable = true;
    managePluginSettings = true;
    plugins = {
      dankKDEConnect.enable = true;
      cavaVisualizer.enable = false;
      musicLyrics.enable = true;
    };
    systemd.enable = true;
    niri = {
      enableSpawn = false;
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
        filesToInclude = ["alttab" "binds" "layout" "outputs" "wpblur" "cursor" "windowrules"];
      };
    };
    enableSystemMonitoring = true;
    enableCalendarEvents = false;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
    session = {
      wallpaperPath = "${src}/users/anisp/assets/Wallpapers/igiveup.jpg";
      isLightMode = false;
    };
    clipboardSettings = {
      maxHistory = 1000;
      autoClearDays = 7;
    };
    settings = {
      currentThemeName = "custom";
      currentThemeCategory = "custom";
      registryThemeVariants = {
      };
      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      matugenTargetMonitor = "";
      popupTransparency = 1.0;
      dockTransparency = 1.0;
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      controlCenterTileColorMode = "primary";
      buttonColorMode = "primary";
      cornerRadius = 0;
      niriLayoutGapsOverride = 0;
      niriLayoutRadiusOverride = -1;
      niriLayoutBorderSize = -1;
      hyprlandLayoutGapsOverride = -1;
      hyprlandLayoutRadiusOverride = -1;
      hyprlandLayoutBorderSize = -1;
      mangoLayoutGapsOverride = -1;
      mangoLayoutRadiusOverride = -1;
      mangoLayoutBorderSize = -1;
      use24HourClock = false;
      showSeconds = true;
      padHours12Hour = true;
      useFahrenheit = false;
      windSpeedUnit = "kmh";
      nightModeEnabled = false;
      animationSpeed = 1;
      customAnimationDuration = 500;
      syncComponentAnimationSpeeds = true;
      popoutAnimationSpeed = 1;
      popoutCustomAnimationDuration = 150;
      modalAnimationSpeed = 1;
      modalCustomAnimationDuration = 150;
      enableRippleEffects = true;
      wallpaperFillMode = "Fill";
      blurredWallpaperLayer = false;
      blurWallpaperOnOverview = false;
      showLauncherButton = true;
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showWeather = true;
      showMusic = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = true;
      selectedGpuIndex = 0;
      enabledGpuPciIds = [
      ];
      showSystemTray = true;
      showClock = true;
      showNotificationButton = true;
      showBattery = false;
      showControlCenterButton = true;
      showCapsLockIndicator = true;
      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowAudioPercent = false;
      controlCenterShowVpnIcon = true;
      controlCenterShowBrightnessIcon = false;
      controlCenterShowBrightnessPercent = false;
      controlCenterShowMicIcon = false;
      controlCenterShowMicPercent = false;
      controlCenterShowBatteryIcon = false;
      controlCenterShowPrinterIcon = false;
      controlCenterShowScreenSharingIcon = true;
      showPrivacyButton = true;
      privacyShowMicIcon = false;
      privacyShowCameraIcon = false;
      privacyShowScreenShareIcon = false;
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }
      ];
      showWorkspaceIndex = false;
      showWorkspaceName = false;
      showWorkspacePadding = false;
      workspaceScrolling = false;
      showWorkspaceApps = false;
      workspaceDragReorder = true;
      maxWorkspaceIcons = 3;
      workspaceAppIconSizeOffset = 0;
      groupWorkspaceApps = true;
      workspaceFollowFocus = false;
      showOccupiedWorkspacesOnly = false;
      reverseScrolling = false;
      dwlShowAllTags = false;
      workspaceColorMode = "default";
      workspaceOccupiedColorMode = "none";
      workspaceUnfocusedColorMode = "default";
      workspaceUrgentColorMode = "default";
      workspaceFocusedBorderEnabled = false;
      workspaceFocusedBorderColor = "primary";
      workspaceFocusedBorderThickness = 2;
      workspaceNameIcons = {
      };
      waveProgressEnabled = true;
      scrollTitleEnabled = true;
      audioVisualizerEnabled = true;
      audioScrollMode = "volume";
      audioWheelScrollAmount = 5;
      clockCompactMode = false;
      focusedWindowCompactMode = false;
      runningAppsCompactMode = true;
      barMaxVisibleApps = 0;
      barMaxVisibleRunningApps = 0;
      barShowOverflowBadge = true;
      appsDockHideIndicators = false;
      appsDockColorizeActive = false;
      appsDockActiveColorMode = "primary";
      appsDockEnlargeOnHover = false;
      appsDockEnlargePercentage = 125;
      appsDockIconSizePercentage = 100;
      keyboardLayoutNameCompactMode = false;
      runningAppsCurrentWorkspace = true;
      runningAppsGroupByApp = false;
      runningAppsCurrentMonitor = false;
      appIdSubstitutions = [
        {
          pattern = "Spotify";
          replacement = "spotify";
          type = "exact";
        }
        {
          pattern = "beepertexts";
          replacement = "beeper";
          type = "exact";
        }
        {
          pattern = "home assistant desktop";
          replacement = "homeassistant-desktop";
          type = "exact";
        }
        {
          pattern = "com.transmissionbt.transmission";
          replacement = "transmission-gtk";
          type = "contains";
        }
        {
          pattern = "^steam_app_(\\d+)$";
          replacement = "steam_icon_$1";
          type = "regex";
        }
      ];
      centeringMode = "index";
      clockDateFormat = "";
      lockDateFormat = "";
      mediaSize = 1;
      appLauncherViewMode = "list";
      spotlightModalViewMode = "list";
      browserPickerViewMode = "grid";
      browserUsageHistory = {
      };
      appPickerViewMode = "grid";
      filePickerUsageHistory = {
      };
      sortAppsAlphabetically = false;
      appLauncherGridColumns = 4;
      spotlightCloseNiriOverview = true;
      spotlightSectionViewModes = {
      };
      appDrawerSectionViewModes = {
      };
      niriOverviewOverlayEnabled = true;
      dankLauncherV2Size = "compact";
      dankLauncherV2BorderEnabled = false;
      dankLauncherV2BorderThickness = 2;
      dankLauncherV2BorderColor = "primary";
      dankLauncherV2ShowFooter = true;
      dankLauncherV2UnloadOnClose = false;
      useAutoLocation = true;
      weatherEnabled = false;
      networkPreference = "auto";
      iconTheme = "System Default";
      cursorSettings = {
        niri = {
          hideWhenTyping = true;
        };
        size = 16;
        theme = "BreezeX-RosePineDawn-Linux";
      };
      launcherLogoMode = "os";
      launcherLogoCustomPath = "";
      launcherLogoColorOverride = "primary";
      launcherLogoColorInvertOnMode = false;
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;
      launcherLogoSizeOffset = 0;
      fontFamily = "Noto Sans";
      monoFontFamily = "Google Sans Code NF";
      fontWeight = 400;
      fontScale = 1;
      notepadUseMonospace = true;
      notepadFontFamily = "";
      notepadFontSize = 14;
      notepadShowLineNumbers = false;
      notepadTransparencyOverride = -1;
      notepadLastCustomTransparency = 0.7;
      soundsEnabled = true;
      useSystemSoundTheme = false;
      soundNewNotification = true;
      soundVolumeChanged = true;
      soundPluggedIn = true;
      acMonitorTimeout = 300;
      acLockTimeout = 180;
      acSuspendTimeout = 0;
      acSuspendBehavior = 0;
      acProfileName = "";
      batteryMonitorTimeout = 0;
      batteryLockTimeout = 0;
      batterySuspendTimeout = 0;
      batterySuspendBehavior = 0;
      batteryProfileName = "";
      batteryChargeLimit = 100;
      lockBeforeSuspend = false;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;
      launchPrefix = "";
      brightnessDevicePins = {
      };
      wifiNetworkPins = {
      };
      bluetoothDevicePins = {
      };
      audioInputDevicePins = {
      };
      audioOutputDevicePins = {
      };
      gtkThemingEnabled = true;
      qtThemingEnabled = true;
      syncModeWithPortal = true;
      terminalsAlwaysDark = false;
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
      matugenTemplateNeovim = false;
      matugenTemplateWezterm = false;
      matugenTemplateDgop = false;
      matugenTemplateKcolorscheme = false;
      matugenTemplateVscode = false;
      matugenTemplateEmacs = false;
      showDock = true;
      dockAutoHide = true;
      dockSmartAutoHide = true;
      dockGroupByApp = false;
      dockOpenOnOverview = false;
      dockPosition = 2;
      dockSpacing = 4;
      dockBottomGap = 0;
      dockMargin = 0;
      dockIconSize = 40;
      dockIndicatorStyle = "circle";
      dockBorderEnabled = false;
      dockBorderColor = "surfaceText";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;
      dockIsolateDisplays = false;
      dockLauncherEnabled = false;
      dockLauncherLogoMode = "apps";
      dockLauncherLogoCustomPath = "";
      dockLauncherLogoColorOverride = "";
      dockLauncherLogoSizeOffset = 0;
      dockLauncherLogoBrightness = 0.5;
      dockLauncherLogoContrast = 1;
      dockMaxVisibleApps = 0;
      dockMaxVisibleRunningApps = 0;
      dockShowOverflowBadge = true;
      # this fucker needed to be turned off because osu
      notificationOverlayEnabled = false;
      notificationPopupShadowEnabled = true;
      notificationPopupPrivacyMode = false;
      modalDarkenBackground = true;
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenShowMediaPlayer = true;
      lockScreenPowerOffMonitorsOnLock = false;
      lockAtStartup = false;
      enableFprint = false;
      maxFprintTries = 15;
      lockScreenActiveMonitor = "all";
      lockScreenInactiveColor = "#000000";
      lockScreenNotificationMode = 2;
      hideBrightnessSlider = false;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationTimeoutCritical = 0;
      notificationCompactMode = true;
      notificationPopupPosition = 0;
      notificationAnimationSpeed = 1;
      notificationCustomAnimationDuration = 400;
      notificationHistoryEnabled = true;
      notificationHistoryMaxCount = 50;
      notificationHistoryMaxAgeDays = 7;
      notificationHistorySaveLow = true;
      notificationHistorySaveNormal = true;
      notificationHistorySaveCritical = true;
      notificationRules = [
      ];
      osdAlwaysShowValue = false;
      osdPosition = 5;
      osdVolumeEnabled = true;
      osdMediaVolumeEnabled = true;
      osdMediaPlaybackEnabled = true;
      osdBrightnessEnabled = true;
      osdIdleInhibitorEnabled = true;
      osdMicMuteEnabled = true;
      osdCapsLockEnabled = true;
      osdPowerProfileEnabled = true;
      osdAudioOutputEnabled = true;
      powerActionConfirm = true;
      powerActionHoldDuration = 0.5;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
      ];
      powerMenuDefaultAction = "logout";
      powerMenuGridLayout = false;
      customPowerActionLock = "";
      customPowerActionLogout = "";
      customPowerActionSuspend = "";
      customPowerActionHibernate = "";
      customPowerActionReboot = "";
      customPowerActionPowerOff = "";
      updaterHideWidget = false;
      updaterUseCustomCommand = false;
      updaterCustomCommand = "";
      updaterTerminalAdditionalParams = "";
      displayNameMode = "system";
      screenPreferences = {
      };
      showOnLastDisplay = {
      };
      niriOutputSettings = {
        eDP-1 = {
          vrrOnDemand = true;
          hotCorners = null;
          layout = null;
        };
      };
      hyprlandOutputSettings = {
      };
      displayProfiles = {
      };
      activeDisplayProfile = {
      };
      displayProfileAutoSelect = false;
      displayShowDisconnected = false;
      displaySnapToEdge = true;
      barConfigs = [
        {
          autoHide = true;
          borderEnabled = false;
          centerWidgets = [
            {
              enabled = true;
              id = "musicLyrics";
            }
            {
              enabled = true;
              id = "clock";
            }
          ];
          enabled = true;
          id = "default";
          innerPadding = 0;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
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
            }
            {
              enabled = true;
              id = "notificationButton";
            }
            {
              enabled = true;
              id = "controlCenterButton";
            }
          ];
          scrollXBehavior = "column";
          spacing = 0;
          transparency = 1;
          widgetTransparency = 1;
          autoHideDelay = 1000;
          showOnWindowsOpen = true;
        }
      ];
      desktopClockEnabled = false;
      desktopClockStyle = "analog";
      desktopClockTransparency = 0.8;
      desktopClockColorMode = "primary";
      desktopClockCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      desktopClockShowDate = true;
      desktopClockShowAnalogNumbers = false;
      desktopClockShowAnalogSeconds = true;
      desktopClockX = -1;
      desktopClockY = -1;
      desktopClockWidth = 280;
      desktopClockHeight = 180;
      desktopClockDisplayPreferences = [
        "all"
      ];
      systemMonitorEnabled = false;
      systemMonitorShowHeader = true;
      systemMonitorTransparency = 0.8;
      systemMonitorColorMode = "primary";
      systemMonitorCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      systemMonitorShowCpu = true;
      systemMonitorShowCpuGraph = true;
      systemMonitorShowCpuTemp = true;
      systemMonitorShowGpuTemp = false;
      systemMonitorGpuPciId = "";
      systemMonitorShowMemory = true;
      systemMonitorShowMemoryGraph = true;
      systemMonitorShowNetwork = true;
      systemMonitorShowNetworkGraph = true;
      systemMonitorShowDisk = true;
      systemMonitorShowTopProcesses = false;
      systemMonitorTopProcessCount = 3;
      systemMonitorTopProcessSortBy = "cpu";
      systemMonitorGraphInterval = 60;
      systemMonitorLayoutMode = "auto";
      systemMonitorX = -1;
      systemMonitorY = -1;
      systemMonitorWidth = 320;
      systemMonitorHeight = 480;
      systemMonitorDisplayPreferences = [
        "all"
      ];
      systemMonitorVariants = [
      ];
      desktopWidgetPositions = {
      };
      desktopWidgetGridSettings = {
      };
      desktopWidgetInstances = [
        # {
        #   id = "dw_1774453349265_no7idbovu";
        #   widgetType = "cavaVisualizer";
        #   name = "Cava Visualizer";
        #   enabled = true;
        #   config = {
        #     displayPreferences = [
        #       "all"
        #     ];
        #     showOnOverlay = true;
        #     orientation = "top";
        #     barCount = 128;
        #     barSpacing = 3;
        #     barWidth = 0;
        #     channels = "stereo";
        #     clickThrough = true;
        #     sensitivity = 100;
        #     opacity = 39;
        #     vizMode = "curve-filled";
        #     curvePoints = 128;
        #     curveLineWidth = 1;
        #   };
        #   positions = {
        #     eDP-1 = {
        #       width = 1920;
        #       height = 100;
        #       x = 0;
        #       y = 0;
        #     };
        #   };
        # }
      ];
      desktopWidgetGroups = [
      ];
      builtInPluginSettings = {
        dms_settings_search = {
          trigger = "?";
        };
      };
      clipboardEnterToPaste = true;
      launcherPluginVisibility = {
      };
      launcherPluginOrder = [
      ];
      configVersion = 5;
    };
  };
}
