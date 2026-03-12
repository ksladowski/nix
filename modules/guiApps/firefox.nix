{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  firefox = config.systemSettings.firefox.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf firefox {
    hm = lib.mkIf homeManager {

      ## Currently on a fresh install, this opens all the "first run" tabs for any installed extensions, the sidebar button doesn't appear until the second launch, and the first time you close with tabs open, ff will prompt for you to restore them on next launch. I just open and close ff 2-3 times and it gets all this out of the system
      programs.firefox = {
        enable = true;
        policies = {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableFirefoxAccounts = true;
          DisableFirefoxStudies = true;
          DisableFormHistory = true;
          DisableMasterPasswordCreation = true;
          DisableSetDesktopBackground = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisplayBookmarksToolbar = "never";
          DontCheckDefaultBrowser = true;
          FirefoxHome = {
            Search = true;
            TopSites = false;
            SponsoredTopSites = false;
            Highlights = false;
            Pocket = false;
            Stories = false;
            SponsoredPocket = false;
            SponsoredStories = false;
            Snippets = false;
            Weather = false;
            SupportFirefox = false;
            Locked = true;
          };
          FirefoxSuggest = {
            WebSuggestions = false;
            SponsoredSuggestions = false;
            ImproveSuggest = false;
            Locked = true;
          };
          GenerativeAI = {
            Enabled = false;
            Locked = true;
          };
          UserMessaging = {
            WhatsNew = false;
            ExtensionRecommendations = false;
            FeatureRecommendations = false;
            UrlbarInterventions = false;
            SkipOnboarding = true;
            MoreFromMozilla = false;
          };
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          SearchSuggestEnabled = false;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          NetworkPrediction = false; # Disable DNS prefetching
          PasswordManagerEnabled = false;
        };
        profiles.default = {
          isDefault = true;
          bookmarks = {
            force = true;
            settings = [ ];
          };
          extensions = {
            force = true;
            packages = with inputs.firefox-addons.packages.${pkgs.system}; [
              ublock-origin
              firefox-color
              bitwarden
              vimium-c
            ];
          };
          search = {
            force = true;
            default = "kagi";
            order = [
              "kagi"
              "ddg"
            ];
            engines = {
              kagi = {
                name = "kagi";
                urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
                icon = "https://kagi.com/favicon.ico";
              };
            };
          };
          settings = {
            "browser.tabs.groups.smart.enabled" = false;
            "browser.ml.linkPreview.enabled" = false;
            "browser.newtabpage.activity-stream.system.showWeather" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.loadInBackground" = true;
            "browser.in-content.dark-mode" = true; # Use dark mode
            "ui.systemUsesDarkTheme" = 1; # this weirdly seems to only work when a theme is applied?
            "extensions.autoDisableScopes" = 0; # Auto enable installed extensions
            "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
            "browser.tabs.inTitlebar" = 0;
            "sidebar.verticalTabs" = true;
            "sidebar.revamp" = true;
            "sidebar.expandOnHover" = false;
            "sidebar.visibility" = "always-show";
            "sidebar.main.tools" = [
              "history"
              "bookmarks"
            ];
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
            "browser.urlbar.quicksuggest.enabled" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                widget-overflow-fixed-list = [
                ];
                unified-extensions-area = [
                ];
                nav-bar = [
                  "sidebar-button"
                  "vertical-spacer"
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "downloads-button"
                  "unified-extensions-button"
                ];
                vertical-tabs = [ "tabbrowser-tabs" ];
                PersonalToolbar = [ "personal-bookmarks" ];
              };
              dirtyAreaCache = [
                "nav-bar"
                "TabsToolbar"
                "vertical-tabs"
                "unified-extensions-area"
                "PersonalToolbar"
                "widget-overflow-fixed-list"
              ];
              currentVersion = 23;
              newElementCount = 6;
            };
          };
        };
      };

      stylix.targets.firefox = {
        profileNames = [ "default" ];
        colorTheme.enable = true;
      };
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".mozilla"
      ];
    };
  };
}
