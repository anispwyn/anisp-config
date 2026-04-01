{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];
  programs.vivaldi = {
    enable = true;
    extensions = [
      {id = "ammjkodgmmoknidbanneddgankgfejfh";} # 7tv
      {id = "hhinaapppaileiechjoiifaancjggfjm";} # web-scrobbler
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # proton pass
      {id = "jgejdcdoeeabklepnkdbglgccjpdgpmf";} # oldtwitter
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsorblock
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "likgccmbimhjbgkjambclfkhldnlhbnn";} # yomitan
    ];
  };
  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles.anisp = {
      isDefault = true;
      id = 0;
      name = "anisp";
      path = "anisp";
      # spacesForce = true;
      # spaces = {
      #   "Everything" = {
      #     id = "be5a5603-239b-4da4-be96-55136f11266a";
      #     position = 1000;
      #     icon = "chrome://browser/skin/zen-icons/selectable/cafe.svg";
      #   };
      #   "Social Media" = {
      #     id = "1ea0e54e-2a0c-4200-a4a5-5ac4a03220c4";
      #     position = 2000;
      #     icon = "chrome://browser/skin/zen-icons/selectable/people.svg";
      #   };
      #   "Entertainment" = {
      #     id = "cdb12dd5-adb5-4a0c-ae5e-92ca1306bc71";
      #     position = 3000;
      #     icon = "chrome://browser/skin/zen-icons/selectable/music.svg";
      #   };
      # };
      extensions = let
        inherit (pkgs.firefox-addons) buildFirefoxXpiAddon;
        oldtwitter = buildFirefoxXpiAddon rec {
          pname = "oldtwitter";
          version = "1.9.6.2";
          addonId = "oldtwitter@dimden.dev";
          url = "https://github.com/dimdenGD/OldTwitter/releases/download/v${version}/OldTwitterFirefox.zip";
          sha256 = "sha256-FjuWsaCuqTJfkp3ekY+RY7gkDlet1EibtjS1sBpiIfk=";
          meta = with lib; {
            homepage = "https://github.com/dimdenGD/OldTwitter";
            description = "Browser extension to return old Twitter layout from 2015 (and option to use 2018 design). This extension doesn't add any CSS on top of original Twitter. It's fully original client that replaces Twitter, making it much faster than alternatives.";
            license = {
              shortName = "all-rights-reserved";
              fullName = "All Rights Reserved";
              free = true;
            };
            mozPermissions = [
              "*://*.twitter.com/*"
              "*://twitter.com/*"
              "*://*.twimg.com/*"
              "*://twimg.com/*"
              "*://*.x.com/*"
              "*://x.com/*"
              "*://dimden.dev/*"
              "*://raw.githubusercontent.com/*"
            ];
            platforms = platforms.all;
          };
        };

        yomitan = buildFirefoxXpiAddon rec {
          pname = "yomitan";
          version = "26.2.17.0";
          addonId = "{6b733b82-9261-47ee-a595-2dda294a4d08}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4676339/yomitan-${version}";
          sha256 = "sha256-8Ci4HTFaknOcGYXxIodTwC9O+5i5/+H7TwDp6B/OysA=";
          meta = with lib; {
            homepage = "https://github.com/dimdenGD/OldTwitter";
            description = "Powerful and versatile pop-up dictionary for language learning used by 100,000+ language learners.";
            license = lib.licenses.gpl3;
            mozPermissions = [
              "storage"
              "clipboardWrite"
              "unlimitedStorage"
              "declarativeNetRequest"
              "scripting"
              "contextMenus"
              "clipboard-read"
              "nativeMessaging"
              "<all_urls>"
            ];
            platforms = platforms.all;
          };
        };
      in {
        force = true;

        packages = (with pkgs.firefox-addons; [ublock-origin wappalyzer proton-pass sponsorblock web-scrobbler seventv]) ++ [oldtwitter yomitan];
        settings = {
          "uBlock0@raymondhill.net" = {
            settings = {selectedFilterLists = ["ublock-filters" "ublock-badware" "ublock-privacy" "ublock-quick-fixes" "ublock-unbreak" "easylist" "easyprivacy" "urlhaus-1" "plowe-0" "fanboy-cookiemonster" "ublock-cookies-easylist" "adguard-cookies" "ublock-cookies-adguard" "fanboy-ai-suggestions" "easylist-chat" "easylist-newsletters" "easylist-notifications" "easylist-annoyances" "adguard-mobile-app-banners" "adguard-other-annoyances" "adguard-popup-overlays" "adguard-widgets" "ublock-annoyances"];};
          };
          "sponsorBlocker@ajay.app" = {
            settings = {
              changeChapterColor = true;
              barTypes = {
                preview-chooseACategory = {
                  color = "#ffffff";
                  opacity = "0.7";
                };
                sponsor = {
                  color = "#00d400";
                  opacity = "0.7";
                };
                preview-sponsor = {
                  color = "#007800";
                  opacity = "0.7";
                };
                selfpromo = {
                  color = "#ffff00";
                  opacity = "0.7";
                };
                preview-selfpromo = {
                  color = "#bfbf35";
                  opacity = "0.7";
                };
                exclusive_access = {
                  color = "#008a5c";
                  opacity = "0.7";
                };
                interaction = {
                  color = "#cc00ff";
                  opacity = "0.7";
                };
                preview-interaction = {
                  color = "#6c0087";
                  opacity = "0.7";
                };
                intro = {
                  color = "#00ffff";
                  opacity = "0.7";
                };
                preview-intro = {
                  color = "#008080";
                  opacity = "0.7";
                };
                outro = {
                  color = "#0202ed";
                  opacity = "0.7";
                };
                preview-outro = {
                  color = "#000070";
                  opacity = "0.7";
                };
                preview = {
                  color = "#008fd6";
                  opacity = "0.7";
                };
                preview-preview = {
                  color = "#005799";
                  opacity = "0.7";
                };
                hook = {
                  color = "#395699";
                  opacity = "0.8";
                };
                preview-hook = {
                  color = "#273963";
                  opacity = "0.7";
                };
                music_offtopic = {
                  color = "#ff9900";
                  opacity = "0.7";
                };
                preview-music_offtopic = {
                  color = "#a6634a";
                  opacity = "0.7";
                };
                poi_highlight = {
                  color = "#ff1684";
                  opacity = "0.7";
                };
                preview-poi_highlight = {
                  color = "#9b044c";
                  opacity = "0.7";
                };
                filler = {
                  color = "#7300FF";
                  opacity = "0.9";
                };
                preview-filler = {
                  color = "#2E0066";
                  opacity = "0.7";
                };
                chapter = {
                  color = "#ffd983";
                  opacity = "0";
                };
              };
              chapterCategoryAdded = true;
              autoSkipOnMusicVideosUpdate = true;
              invidiousInstances = [
                "www.youtubekids.com"
                "inv.nadeko.net"
                "inv.tux.pizza"
                "invidious.adminforge.de"
                "invidious.jing.rocks"
                "invidious.nerdvpn.de"
                "invidious.perennialte.ch"
                "invidious.privacyredirect.com"
                "invidious.reallyaweso.me"
                "invidious.yourdevice.ch"
                "iv.ggtyler.dev"
                "iv.nboeck.de"
                "yewtu.be"
              ];
              showZoomToFillError2 = false;
              categoryPillUpdate = true;
              minutesSaved = 0;
              skipCount = 1;
              userID = null;
              isVip = true;
              permissions = {
              };
              defaultCategory = "chooseACategory";
              segmentListDefaultTab = 0;
              renderSegmentsAsChapters = false;
              forceChannelCheck = false;
              sponsorTimesContributed = 0;
              submissionCountSinceCategories = 0;
              showTimeWithSkips = true;
              disableSkipping = false;
              muteSegments = true;
              fullVideoSegments = true;
              fullVideoLabelsOnThumbnails = true;
              manualSkipOnFullVideo = false;
              trackViewCount = true;
              trackViewCountInPrivate = true;
              trackDownvotes = true;
              trackDownvotesInPrivate = false;
              dontShowNotice = false;
              showUpcomingNotice = true;
              noticeVisibilityMode = 3;
              hideVideoPlayerControls = false;
              hideInfoButtonPlayerControls = false;
              hideDeleteButtonPlayerControls = false;
              hideUploadButtonPlayerControls = false;
              hideSkipButtonPlayerControls = false;
              hideDiscordLaunches = 0;
              hideDiscordLink = false;
              supportInvidious = true;
              serverAddress = "https://sponsor.ajay.app";
              minDuration = 0;
              skipNoticeDuration = 4;
              audioNotificationOnSkip = false;
              checkForUnlistedVideos = false;
              testingServer = false;
              ytInfoPermissionGranted = false;
              allowExpirements = true;
              showDonationLink = false;
              showPopupDonationCount = 0;
              showUpsells = false;
              showNewFeaturePopups = true;
              donateClicked = 0;
              autoHideInfoButton = true;
              autoSkipOnMusicVideos = false;
              skipNonMusicOnlyOnYoutubeMusic = false;
              scrollToEditTimeUpdate = false;
              hookUpdate = false;
              showChapterInfoMessage = true;
              darkMode = true;
              showCategoryGuidelines = true;
              showCategoryWithoutPermission = false;
              showSegmentNameInChapterBar = true;
              showAutogeneratedChapters = true;
              useVirtualTime = true;
              showSegmentFailedToFetchWarning = true;
              allowScrollingToEdit = true;
              deArrowInstalled = false;
              showDeArrowPromotion = true;
              showDeArrowInSettings = true;
              shownDeArrowPromotion = false;
              cleanPopup = false;
              hideSegmentCreationInPopup = false;
              prideTheme = false;
              categoryPillColors = {
              };
              skipKeybind = {
                key = "Enter";
              };
              skipToHighlightKeybind = {
                key = "Enter";
                ctrl = true;
              };
              startSponsorKeybind = {
                key = ";";
              };
              submitKeybind = {
                key = "'";
              };
              actuallySubmitKeybind = {
                key = "'";
                ctrl = true;
              };
              previewKeybind = {
                key = ";";
                ctrl = true;
              };
              nextChapterKeybind = {
                key = "ArrowRight";
                ctrl = true;
              };
              previousChapterKeybind = {
                key = "ArrowLeft";
                ctrl = true;
              };
              closeSkipNoticeKeybind = {
                key = "Backspace";
              };
              downvoteKeybind = {
                key = "h";
                shift = true;
              };
              upvoteKeybind = {
                key = "g";
                shift = true;
              };
              categorySelections = [
                {
                  name = "sponsor";
                  option = 2;
                }
                {
                  name = "poi_highlight";
                  option = 1;
                }
                {
                  name = "exclusive_access";
                  option = 0;
                }
                {
                  name = "chapter";
                  option = 0;
                }
              ];
              payments = {
                licenseKey = null;
                lastCheck = 0;
                lastFreeCheck = 0;
                freeAccess = false;
                chaptersAllowed = false;
              };
              colorPalette = {
                red = "#780303";
                white = "#ffffff";
                locked = "#ffc83d";
              };
            };
          };
          "oldtwitter@dimden.dev" = {
            settings = {
              customCSSVariables = ''
                --background-color: #${config.lib.stylix.colors.base01};
                --dark-background-color: #${config.lib.stylix.colors.base02};
                --darker-background-color: #${config.lib.stylix.colors.base00};
                --almost-black: #${config.lib.stylix.colors.base05};
                --border: #${config.lib.stylix.colors.base03}00;
                --darker-gray: #${config.lib.stylix.colors.base04};
                --lil-darker-gray: #${config.lib.stylix.colors.base04};
                --light-gray: #${config.lib.stylix.colors.base03};
                --default-text-color: #${config.lib.stylix.colors.base05};
                --new-tweet-over: #${config.lib.stylix.colors.base02};
                --input-background: #${config.lib.stylix.colors.base01};
                --active-message: #${config.lib.stylix.colors.base02};
                --more-color: #${config.lib.stylix.colors.base0E};
                --choice-bg: #${config.lib.stylix.colors.base0C};
                --list-actions-bg: #${config.lib.stylix.colors.base01};
                --menu-bg: #${config.lib.stylix.colors.base01};
              '';
              linkColor = "#${config.lib.stylix.colors.base0C}";
              slowlinkcolorsintl = false;
              alwaysshowlinkcolor = false;
              enabletwemoji = true;
              timelineType = "algo";
              showtopictweets = true;
              darkmode = true;
              savePreferredQuality = false;
              noBigFont = false;
              language = "en";
              displaySensitiveContent = false;
              displaySensitiveContentMoved = true;
              showOriginalImages = true;
              roundAvatars = false;
              copyLinksAs = "fxtwitter.com";
              showMediaCount = true;
              pinProfileOnNavbar = true;
              useOldDefaultProfileImage = true;
              enableHashflags = false;
              useOldStyleReply = false;
              enableAd = false;
              openNotifsAsModal = true;
              enableIframeNavigation = true;
              modernUI = true;
              showExactValues = true;
              hideTimelineTypes = false;
              autotranslateLanguages = ["ja" "zh"];
              autotranslationMode = "whitelist";
              hideOriginalLanguages = false;
              localizeDigit = false;
              disableAcceptType = false;
              transitionProfileBanner = false;
              customDownloadTemplate = "";
              showBoringIndicators = true;
              extensionCompatibilityMode = false;
              systemDarkMode = true;
              timeMode = true;
              useNewIcon = true;
            };
          };
        };
      };
      settings = {
        "xpinstall.signatures.required" = false;
        "general.autoScroll" = true;
      };
    };
  };
  stylix.targets.zen-browser.profileNames = ["anisp"];
}
