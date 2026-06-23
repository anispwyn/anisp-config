{inputs, ...}: {
  imports = [inputs.nixcord.homeModules.nixcord];

  programs.nixcord = {
    enable = true;
    discord.vencord.enable = true; # fallback for everything idk
    # discord.equicord.enable = true;
    equibop.enable = true;
    quickCss = ''
      /**
       * @name Horizontal Server List
       * @author Gibbu
       * @version 3.0.0
       * @description Moves the server list from the left to the top of Discord.
       * @source https://github.com/DiscordStyles/HorizontalServerList
       * @invite ZHthyCw
      */
      @import url('https://discordstyles.github.io/HorizontalServerList/HorizontalServerList.css');
      /* Bottom HorizontalServerList. Simply remove the comments surrounding the @import to enable it. */
      /* @import url("https://discordstyles.github.io/HorizontalServerList/bottomhsl.css"); */
      :root {
        --HSL-server-direction: column; /* Direction of the server list. | OPTIONS: column, column-reverse | DEFAULT: column */
        --HSL-server-alignment: flex-start; /* Alignment of the server list. | OPTIONS: flex-start, center, flex-end | DEFAULT: flex-start */
      }
    '';
    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      frameless = true;
      useQuickCss = false;
      plugins = {
        blurNsfw.enable = true;
        clearUrls.enable = true;
        lastFmRichPresence = {
          enable = true;
          hideWithActivity = true;
          username = "fame1219";
        };
        reviewDb.enable = true;
        callTimer.allCallTimers = true;
        anonymiseFileNames.enable = true;
        betterFolders.enable = true;
        betterSessions.enable = true;
        dearrow.enable = true;
        fakeNitro.enable = true;
        fixImagesQuality.enable = true;
        fixYoutubeEmbeds.enable = true;
        imageZoom.enable = true;
        messageLogger.enable = true;
        noNitroUpsell.enable = true;
        noReplyMention.enable = true;
        previewMessage.enable = true;
        quickReply.enable = true;
        relationshipNotifier.enable = true;
        shikiCodeblocks = {
          enable = true;
          theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/rose-pine.json";
        };
        showHiddenChannels.enable = true;
        showMeYourName.enable = true;
        viewRaw.enable = true;
        whoReacted.enable = true;
        spotifyCrack.enable = true;
        webScreenShareFixes.enable = true;

        # Equicord stuff
        fontLoader = {
          enable = true;
          selectedFont = "Google Sans";
        };
      };
    };
  };
}
