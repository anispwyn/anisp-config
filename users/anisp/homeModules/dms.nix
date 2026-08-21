{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.homeModules.default
  ];
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
        filesToInclude = ["alttab" "binds" "layout" "outputs" "wpblur" "cursor" "windowrules"];
      };
    };
    enableSystemMonitoring = true;
    enableCalendarEvents = false;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableClipboardPaste = true;
    session = {
      isLightMode = false;
      doNotDisturb = false;
      doNotDisturbUntil = 0;
      terminalOverride = "";
      wallpaperPath = ../assets/Wallpapers/HLoAT6paUAA2nXU.jpg;
      perMonitorWallpaper = false;
      monitorWallpapers = {
      };
      perModeWallpaper = false;
      wallpaperPathLight = "";
      wallpaperPathDark = "";
      monitorWallpapersLight = {
      };
      monitorWallpapersDark = {
      };
      monitorWallpaperFillModes = {
      };
      wallpaperTransition = "fade";
      includedTransitions = [
        "fade"
        "wipe"
        "disc"
        "stripes"
        "iris bloom"
        "pixelate"
        "portal"
      ];
      wallpaperCyclingEnabled = false;
      wallpaperCyclingMode = "interval";
      wallpaperCyclingInterval = 300;
      wallpaperCyclingTime = "06:00";
      monitorCyclingSettings = {
      };
      nightModeEnabled = false;
      nightModeTemperature = 4500;
      nightModeHighTemperature = 6500;
      nightModeAutoEnabled = false;
      nightModeAutoMode = "time";
      nightModeStartHour = 18;
      nightModeStartMinute = 0;
      nightModeEndHour = 6;
      nightModeEndMinute = 0;
      latitude = 0;
      longitude = 0;
      nightModeUseIPLocation = false;
      nightModeLocationProvider = "";
      themeModeAutoEnabled = false;
      themeModeAutoMode = "time";
      themeModeStartHour = 18;
      themeModeStartMinute = 0;
      themeModeEndHour = 6;
      themeModeEndMinute = 0;
      themeModeShareGammaSettings = true;
      pinnedApps = [
      ];
      barPinnedApps = [
      ];
      dockLauncherPosition = 0;
      hiddenTrayIds = [
      ];
      trayItemOrder = [
      ];
      recentColors = [
      ];
      showThirdPartyPlugins = false;
      pluginBrowserInstalledFirst = false;
      pluginBrowserSortMode = "default";
      launchPrefix = "";
      lastBrightnessDevice = "";
      brightnessExponentialDevices = {
      };
      brightnessUserSetValues = {
      };
      brightnessExponentValues = {
      };
      selectedGpuIndex = 0;
      nvidiaGpuTempEnabled = false;
      nonNvidiaGpuTempEnabled = false;
      enabledGpuPciIds = [
      ];
      wifiDeviceOverride = "";
      weatherHourlyDetailed = true;
      hiddenApps = [
      ];
      appOverrides = {
      };
      searchAppActions = true;
      deviceMaxVolumes = {
      };
      hiddenOutputDeviceNames = [
      ];
      hiddenInputDeviceNames = [
      ];
      locale = "";
      timeLocale = "";
      notepadLastMode = "";
      launcherLastMode = "all";
      launcherLastFileSearchType = "all";
      launcherLastQuery = "";
      # launcherQueryHistory = [
      #   "nixpkgs"
      #   "aaaa"
      #   "disc"
      #   "pear"
      # ];
      appDrawerLastMode = "apps";
      niriOverviewLastMode = "apps";
      settingsSidebarExpandedIds = ",workspaces_widgets,dock_launcher,displays,applications,system,power_security,";
      settingsSidebarCollapsedIds = ",dankbar,";
      configVersion = 3;
    };
    clipboardSettings = {
      maxHistory = 1000;
      autoClearDays = 7;
    };
    settings = let
      opacity = 1;
    in {
      currentThemeName = "custom";
      currentThemeCategory = "custom";
      registryThemeVariants = {
      };
      matugenScheme = "scheme-tonal-spot";
      matugenContrast = 0;
      runUserMatugenTemplates = true;
      matugenTargetMonitor = "";
      popupTransparency = lib.mkForce opacity;
      dockTransparency = lib.mkForce opacity;
      widgetBackgroundColor = "sch";
      widgetBackgroundCustomColor = "#6750A4";
      widgetBackgroundCustomStrength = opacity;
      widgetColorMode = "default";
      controlCenterTileColorMode = "primary";
      buttonColorMode = "primary";
      cornerRadius = 0;
      niriLayoutGapsOverride = -1;
      niriLayoutRadiusOverride = -1;
      niriLayoutBorderSize = -1;
      hyprlandLayoutGapsOverride = -1;
      hyprlandLayoutGapsOutOverride = -1;
      hyprlandLayoutRadiusOverride = -1;
      hyprlandLayoutBorderSize = -1;
      hyprlandResizeOnBorder = false;
      mangoLayoutGapsOverride = -1;
      mangoLayoutGapsOutOverride = -1;
      mangoLayoutRadiusOverride = -1;
      mangoLayoutBorderSize = -1;
      mangoTrackpadNaturalScrolling = true;
      firstDayOfWeek = -1;
      showWeekNumber = false;
      calendarBackend = "auto";
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
      animationVariant = 2;
      motionEffect = 2;
      m3ElevationEnabled = true;
      m3ElevationIntensity = 12;
      m3ElevationOpacity = 30;
      m3ElevationColorMode = "default";
      m3ElevationLightDirection = "top";
      m3ElevationCustomColor = "#000000";
      modalElevationEnabled = true;
      popoutElevationEnabled = true;
      barElevationEnabled = false;
      blurEnabled = false;
      blurForegroundLayers = true;
      blurLayerOutlineOpacity = 0.12;
      blurBorderColor = "outline";
      blurBorderCustomColor = "#ffffff";
      blurBorderOpacity = 0;
      wallpaperFillMode = "Fill";
      blurredWallpaperLayer = true;
      blurWallpaperOnOverview = false;
      wallpaperBackgroundColorMode = "black";
      wallpaperBackgroundCustomColor = "#000000";
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
      systemTrayIconTintMode = "none";
      systemTrayIconTintSaturation = 50;
      systemTrayIconTintStrength = 135;
      showClock = true;
      showNotificationButton = true;
      showBattery = false;
      showBatteryPercent = false;
      showBatteryPercentOnlyOnBattery = false;
      showBatteryTime = false;
      showBatteryTimeOnlyOnBattery = false;
      batteryPillStyle = false;
      batteryPillPercentSign = false;
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
      controlCenterShowIdleInhibitorIcon = false;
      controlCenterShowDoNotDisturbIcon = false;
      showPrivacyButton = true;
      privacyShowMicIcon = false;
      privacyShowCameraIcon = false;
      privacyShowScreenShareIcon = false;
      controlCenterWidgets = [
        {
          enabled = true;
          id = "volumeSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "brightnessSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "wifi";
          width = 50;
        }
        {
          enabled = true;
          id = "bluetooth";
          width = 50;
        }
        {
          enabled = true;
          id = "audioOutput";
          width = 50;
        }
        {
          enabled = true;
          id = "audioInput";
          width = 50;
        }
        {
          enabled = true;
          id = "nightMode";
          width = 50;
        }
        {
          enabled = true;
          id = "darkMode";
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
      groupActiveWorkspaceApps = false;
      workspaceFollowFocus = false;
      showOccupiedWorkspacesOnly = false;
      reverseScrolling = false;
      dwlShowAllTags = false;
      workspaceActiveAppHighlightEnabled = false;
      workspaceColorMode = "default";
      workspaceFocusedCustomColor = "#6750A4";
      workspaceOccupiedColorMode = "none";
      workspaceOccupiedCustomColor = "#625B71";
      workspaceUnfocusedColorMode = "default";
      workspaceUnfocusedCustomColor = "#49454E";
      workspaceUrgentColorMode = "default";
      workspaceUrgentCustomColor = "#B3261E";
      workspaceFocusedBorderEnabled = false;
      workspaceFocusedBorderColor = "primary";
      workspaceFocusedBorderCustomColor = "#6750A4";
      workspaceFocusedBorderThickness = 2;
      workspaceUnfocusedMonitorSeparateAppearance = false;
      workspaceUnfocusedMonitorColorMode = "default";
      workspaceUnfocusedMonitorFocusedCustomColor = "#6750A4";
      workspaceUnfocusedMonitorOccupiedColorMode = "none";
      workspaceUnfocusedMonitorOccupiedCustomColor = "#625B71";
      workspaceUnfocusedMonitorUnfocusedColorMode = "default";
      workspaceUnfocusedMonitorUnfocusedCustomColor = "#49454E";
      workspaceUnfocusedMonitorUrgentColorMode = "default";
      workspaceUnfocusedMonitorUrgentCustomColor = "#B3261E";
      workspaceUnfocusedMonitorBorderEnabled = false;
      workspaceUnfocusedMonitorBorderColor = "primary";
      workspaceUnfocusedMonitorBorderCustomColor = "#6750A4";
      workspaceUnfocusedMonitorBorderThickness = 2;
      workspaceNameIcons = {
      };
      waveProgressEnabled = true;
      scrollTitleEnabled = true;
      mediaAdaptiveWidthEnabled = true;
      audioVisualizerEnabled = true;
      audioScrollMode = "volume";
      audioWheelScrollAmount = 5;
      audioDeviceScrollVolumeEnabled = false;
      mediaExcludePlayers = [
      ];
      clockCompactMode = false;
      focusedWindowCompactMode = false;
      focusedWindowSize = 1;
      focusedWindowShowIcon = true;
      runningAppsCompactMode = true;
      barMaxVisibleApps = 0;
      barMaxVisibleRunningApps = 0;
      barShowOverflowBadge = true;
      trayAutoOverflow = true;
      trayPopupSingleLine = true;
      trayMaxVisibleItems = 0;
      appsDockHideIndicators = false;
      appsDockColorizeActive = false;
      appsDockActiveColorMode = "primary";
      appsDockEnlargeOnHover = false;
      appsDockEnlargePercentage = 125;
      appsDockIconSizePercentage = 100;
      keyboardLayoutNameCompactMode = false;
      keyboardLayoutNameShowIcon = false;
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
      greeterRememberLastSession = true;
      greeterRememberLastUser = true;
      greeterAutoLogin = false;
      greeterEnableFprint = false;
      greeterEnableU2f = false;
      greeterWallpaperPath = "";
      greeterUse24HourClock = true;
      greeterShowSeconds = false;
      greeterPadHours12Hour = false;
      greeterLockDateFormat = "";
      greeterFontFamily = "";
      greeterWallpaperFillMode = "";
      greeterSyncPending = false;
      greeterSyncBaseline = {
      };
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
      rememberLastQuery = false;
      rememberLastMode = true;
      spotlightSectionViewModes = {
      };
      appDrawerSectionViewModes = {
      };
      niriOverviewOverlayEnabled = true;
      dankLauncherV2Size = "compact";
      dankLauncherV2ShowSourceBadges = true;
      dankLauncherV2BorderEnabled = false;
      dankLauncherV2BorderThickness = 2;
      dankLauncherV2BorderColor = "primary";
      dankLauncherV2ShowFooter = true;
      dankLauncherV2UnloadOnClose = false;
      dankLauncherV2IncludeFilesInAll = false;
      dankLauncherV2IncludeFoldersInAll = false;
      launcherUseOverlayLayer = false;
      launcherStyle = "full";
      spotlightBarShowModeChips = false;
      keybindsFloatingWindow = false;
      useAutoLocation = true;
      weatherEnabled = false;
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
      ];
      networkPreference = "auto";
      iconThemeDark = "System Default";
      iconThemeLight = "System Default";
      iconThemePerMode = false;
      lastAppliedIconTheme = "";
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
      monoFontFamily = "Google Sans Code Nerd Font";
      fontWeight = 400;
      fontScale = 1;
      textRenderType = 0;
      textRenderQuality = 4;
      notepadUseMonospace = true;
      notepadFontFamily = "";
      notepadFontSize = 14;
      notificationSummaryFontSize = 0;
      notificationBodyFontSize = 0;
      notepadShowLineNumbers = false;
      notepadAutoSave = false;
      notepadSlideoutSide = "right";
      notepadDefaultMode = "slideout";
      notepadTransparencyOverride = -1;
      notepadLastCustomTransparency = 0.7;
      notepadUseCompositorGap = false;
      notepadEdgeGap = 0;
      soundsEnabled = true;
      useSystemSoundTheme = false;
      soundLogin = false;
      soundNewNotification = true;
      soundVolumeChanged = true;
      soundPluggedIn = true;
      muteSoundsWhenMediaPlaying = true;
      acMonitorTimeout = 300;
      acLockTimeout = 180;
      acSuspendTimeout = 0;
      acSuspendBehavior = 0;
      acProfileName = "";
      acPostLockMonitorTimeout = 0;
      batteryMonitorTimeout = 0;
      batteryLockTimeout = 0;
      batterySuspendTimeout = 0;
      batterySuspendBehavior = 0;
      batteryProfileName = "";
      batteryPostLockMonitorTimeout = 0;
      batteryChargeLimit = 100;
      batteryNotifyChargeLimit = false;
      batteryCriticalThreshold = 10;
      batteryNotifyCritical = true;
      batteryLowThreshold = 20;
      batteryNotifyLow = false;
      batteryChargeLimitNotificationType = 0;
      batteryLowNotificationType = 0;
      batteryCriticalNotificationType = 1;
      batteryAutoPowerSaver = false;
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
      muxType = "tmux";
      muxUseCustomCommand = false;
      muxCustomCommand = "";
      muxSessionFilter = "";
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
      matugenTemplateVencord = true;
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
      matugenTemplateZed = false;
      matugenTemplateNeovimSettings = {
        dark = {
          baseTheme = "github_dark";
          harmony = 0.5;
        };
        light = {
          baseTheme = "github_light";
          harmony = 0.5;
        };
      };
      matugenTemplateNeovimSetBackground = false;
      showDock = true;
      dockAutoHide = true;
      dockSmartAutoHide = true;
      dockUseOverlayLayer = false;
      dockGroupByApp = false;
      dockRestoreSpecialWorkspaceOnClick = false;
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
      dockShowTrash = false;
      dockTrashFileManager = "default";
      dockTrashCustomCommand = "";
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
      enableU2f = false;
      u2fMode = "or";
      lockScreenInactiveColor = "#000000";
      lockScreenNotificationMode = 2;
      lockScreenVideoEnabled = false;
      lockScreenVideoPath = "";
      lockScreenVideoCycling = false;
      lockScreenWallpaperPath = "";
      lockScreenWallpaperFillMode = "";
      lockScreenFontFamily = "";
      hideBrightnessSlider = false;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationTimeoutCritical = 0;
      notificationCompactMode = true;
      notificationShowTimeoutBar = true;
      notificationDedupeEnabled = true;
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
      notificationFocusedMonitor = false;
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
      updaterCheckOnStart = false;
      updaterUseCustomCommand = false;
      updaterCustomCommand = "";
      updaterTerminalAdditionalParams = "";
      updaterIntervalSeconds = 1800;
      updaterIncludeFlatpak = true;
      updaterAllowAUR = true;
      displayNameMode = "system";
      screenPreferences = {
      };
      showOnLastDisplay = {
      };
      niriOutputSettings = {
        eDP-1 = {
          hotCorners = null;
          layout = null;
          vrrOnDemand = true;
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
      connectedFrameBarStyleBackups = {
      };
      barConfigs = [
        {
          autoHide = true;
          autoHideDelay = 1000;
          borderEnabled = false;
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
          showOnWindowsOpen = true;
          spacing = 0;
          transparency = opacity;
          widgetTransparency = 1;
          squareCorners = true;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          removeWidgetPadding = false;
          maximizeWidgetText = false;
          maximizeWidgetIcons = false;
          widgetOutlineEnabled = false;
          autoHideStrict = false;
          hoverPopouts = false;
          maximizeDetection = true;
          shadowIntensity = 0;
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
        dms_clipboard_search = {
          trigger = "cb";
        };
      };
      clipboardClickToPaste = false;
      clipboardEnterToPaste = true;
      clipboardRememberTypeFilter = false;
      clipboardTypeFilter = "all";
      clipboardVisibleEntryActions = [
        "pin"
        "edit"
        "delete"
      ];
      launcherPluginVisibility = {
      };
      launcherPluginOrder = [
      ];
      frameEnabled = false;
      frameThickness = 16;
      frameRounding = 23;
      frameColor = "";
      frameOpacity = 1;
      frameScreenPreferences = [
        "all"
      ];
      frameBarSize = 40;
      frameShowOnOverview = false;
      frameBlurEnabled = true;
      frameCloseGaps = true;
      frameLauncherEmergeSide = "bottom";
      frameLauncherArcExtender = false;
      frameLauncherEdgeHover = false;
      frameMode = "connected";
      barInsetPaddingShared = -1;
      barInsetPaddingSyncAll = false;
      frameBarInsetPadding = -1;
      configVersion = 12;
      iconTheme = "System Default";
      lockScreenActiveMonitor = "all";
    };
  };
}
