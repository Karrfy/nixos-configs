{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  options = {
    home-configurations.social.voicechat = {
      enable = lib.mkEnableOption {
        description = "Enables social apps home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.social.voicechat.enable {

    programs.nixcord = {
      enable = true;

      discord = {
        branch = "stable";
        equicord.enable = true;
        vencord.enable = false;
        krisp.enable = true;
        #openASAR.enable = true;
      };

      config = {
        frameless = true;
        enableReactDevtools = true;
        transparent = false;

        plugins = {
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
          };
          betterSessions.enable = true;
          biggerStreamPreview.enable = true;
          BlurNSFW.enable = true;
          ClearURLs.enable = true;
          consoleJanitor.enable = true;
          copyFileContents.enable = true;
          crashHandler = {
            enable = true;
            attemptToPreventCrashes = true;
          };
          disableCallIdle.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
          };
          fixCodeblockGap.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          friendsSince.enable = true;
          gameActivityToggle = {
            enable = true;
            location = "PANEL";
            oldIcon = true;
          };
          imageZoom = {
            enable = true;
            invertScroll = true;
            size = 275.0;
            square = true;
            zoom = 2.8;
            zoomSpeed = 6.3;
          };
          messageLogger = {
            enable = true;
            collapseDeleted = false;
            deleteStyle = "text";
            ignoreBots = false;
            ignoreSelf = false;
            ignoreSelfEdits = false;
            inlineEdits = true;
            logDeletes = true;
            logEdits = true;
          };
          noF1.enable = true;
          noOnboardingDelay.enable = true;
          noReplyMention = {
            enable = true;
            shouldPingListed = false;
          };
          openInApp = {
            enable = true;
            spotify = true;
            itunes = true;
            tidal = true;
          };
          platformIndicators = {
            enable = true;
            colorMobileIndicator = true;
            list = true;
            messages = false;
            profiles = true;
            showBots = false;
          };
          replaceGoogleSearch.enable = true;
          revealAllSpoilers.enable = true;
          reverseImageSearch.enable = true;
          sendTimestamps = {
            enable = true;
            replaceMessageContents = true;
          };
          shikiCodeblocks.enable = true;
          showConnections.enable = true;
          showHiddenThings.enable = true;
          silentTyping = {
            enable = true;
            chatContextMenu = true;
            chatIcon = true;
            defaultHidden = true;
          };
          spotifyCrack = {
            enable = true;
            noSpotifyAutoPause = true;
          };
          userVoiceShow = {
            showInMemberList = true;
            showInMessages = true;
            showInUserProfileModal = true;
          };
          validReply.enable = true;
          validUser.enable = true;
          viewIcons.enable = true;
          voiceChatDoubleClick.enable = true;
          voiceDownload.enable = true;
          voiceMessages = {
            enable = true;
            echoCancellation = true;
            noiseSuppression = true;
          };
          volumeBooster = {
            enable = true;
            multiplier = 2.0;
          };
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
