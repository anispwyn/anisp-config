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
    session = {
      wallpaperPath = ../assets/Wallpapers/HLoAT6paUAA2nXU.jpg;
      niriOutputSettings = {
        eDP-1 = {
          hotCorners = null;
          layout = null;
          vrrOnDemand = true;
        };
      };
      settingsSidebarExpandedIds = ",dock_launcher,applications,system,power_security,dankbar,workspaces_widgets,displays,";
      configVersion = 4;
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
      widgetBackgroundCustomStrength = opacity;
      cornerRadius = 0;
      keyboardLayouts = "us,th";
      keyboardOptions = "grp:alt_shift_toggle";
      clockFormat = "12h";
      showSeconds = true;
      padHours12Hour = true;
      animationSpeed = 4;
      customAnimationDuration = 200;
      springBounce = 2;
      animationVariant = 2;
      motionEffect = 2;
      barElevationEnabled = false;
      blurBorderOpacity = 0;
      blurredWallpaperLayer = true;
      showBattery = false;
      showBatteryPercent = false;
      mediaUseAlbumArtAccent = true;
      spotlightBarShowModeChips = true;
      useAutoLocation = true;
      weatherEnabled = false;
      dashTabs = [
        {
          enabled = true;
          id = "overview";
        }
        {
          enabled = true;
          id = "media";
        }
        {
          enabled = false;
          id = "wallpaper";
        }
        {
          enabled = false;
          id = "weather";
        }
        {
          enabled = false;
          id = "settings";
        }
      ];
      cursorSettings = {
        niri = {
          hideWhenTyping = true;
        };
        size = 16;
        theme = "BreezeX-RosePineDawn-Linux";
      };
      launcherLogoMode = "os";
      launcherLogoColorOverride = "primary";
      fontFamily = "Noto Sans";
      monoFontFamily = "Google Sans Code Nerd Font";
      textRenderQuality = 4;
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
      showDock = true;
      dockAutoHide = true;
      dockSmartAutoHide = true;
      dockPosition = 2;
      dockIndicatorStyle = "line";
      lockScreenNotificationMode = 2;
      notificationCompactMode = true;
      notificationShowTimeoutBar = true;
      osdMediaPlaybackEnabled = true;
      osdPowerProfileEnabled = true;
      barConfigs = [
        {
          autoHide = true;
          autoHideDelay = 1000;
          autoHideStrict = false;
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
          removeWidgetPadding = false;
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
          shadowIntensity = 0;
          showOnWindowsOpen = true;
          spacing = 0;
          squareCorners = true;
          transparency = opacity;
          widgetOutlineEnabled = false;
          widgetTransparency = opacity;
          bottomGap = 0;
          useOverlayLayer = false;
        }
      ];
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
      builtInPluginSettings = {
        dms_clipboard_search = {
          trigger = "cb";
        };
        dms_settings_search = {
          trigger = "?";
        };
        dms_power = {
          trigger = "pw";
        };
        dms_qr_generator = {
          trigger = "qrg";
        };
      };
      clipboardEnterToPaste = true;
      configVersion = 18;
    };
  };
};
}
