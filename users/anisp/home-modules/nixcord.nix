{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nixcord.homeModules.nixcord];

  programs.nixcord = {
    enable = true;
    discord.enable = true;
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
      useQuickCss = true;
      plugins = {
        BlurNSFW.enable = true;
        ClearURLs.enable = true;
        LastFMRichPresence = {
          enable = true;
          hideWithActivity = true;
          username = "fame1219";
        };
        ReviewDB.enable = true;
        callTimer.allCallTimers = true;
        anonymiseFileNames.enable = true;
        betterFolders.enable = false;
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
          theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/rose-pine.json";
        };
        showHiddenChannels.enable = true;
        showMeYourName.enable = true;
        viewRaw.enable = true;
        whoReacted.enable = true;
        spotifyCrack.enable = true;
      };
    };
  };
}
