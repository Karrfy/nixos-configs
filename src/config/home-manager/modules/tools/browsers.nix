{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
  ];

  options = {
    home-configurations.tools.browsers = {
      enable = lib.mkEnableOption {
        description = "Enables browser apps home manager configurations.";
        default = true;
      };
      enableExtraBrowsers = lib.mkEnableOption {
        description = "Enables extra browser apps home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.home-configurations.tools.browsers.enable {
      programs.firefox = {
        enable = true;
        profiles.default = {
          search = {
            force = true;
            default = "ddg";
          };
          settings = {
            "browser.aboutConfig.showWarning" = false;
            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.suggest.recentsearches" = false;
            "browser.tabs.hoverPreview.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.urlbar.showSearchTerms.enabled" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "browser.formfill.enable" = false;
            "signon.rememberSignons" = false;
            "privacy.globalprivacycontrol.enabled" = true;
          };
        };
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar = "always"; # alternatives: "never" or "newtab"
          DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"
          DNSOverHTTPS = {
            Enabled = true;
          };

          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "gdpr@cavi.au.dk" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
              installation_mode = "force_installed";
            };
            "@contain-facebook" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/facebook-container/latest.xpi";
              installation_mode = "force_installed";
            };
            "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
              installation_mode = "force_installed";
            };
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
              installation_mode = "force_installed";
            };
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
            };
            "{9a3104a2-02c2-464c-b069-82344e5ed4ec}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-no-translation/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
    })

    (lib.mkIf
      (
        config.home-configurations.tools.browsers.enable
        && config.home-configurations.tools.browsers.enableExtraBrowsers
      )
      {
        home.packages = with pkgs; [
          ungoogled-chromium
          tor-browser
        ];
      }
    )
  ];

}
