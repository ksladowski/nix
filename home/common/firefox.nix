{ inputs, outputs, config, pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    policies = {
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
      NetworkPrediction = false; #Disable DNS prefetching
      PasswordManagerEnabled = false;
    };
    profiles.default = {
      isDefault = true;
      extensions.force = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
          bitwarden
          consent-o-matic
          vimium-c
      ];
      search = {
        force = true;
        default = "searx";
        order = [ "searx" "ddg" ];
        engines = {
          searx = {
            name = "searx";
            urls = [{ template = "https://searx.sladnet.xyz/?q={searchTerms}"; }];
            icon = "https://searx.sladnet.xyz/favicon.ico";
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
        "ui.systemUsesDarkTheme" = true;
        "extensions.autoDisableScopes" = 0; # Auto enable installed extensions
        "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
      };
    };
  };
  stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.firefox.colorTheme.enable = true;

}
