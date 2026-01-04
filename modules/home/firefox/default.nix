{ inputs, config, pkgs, ... }:
{

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
      NetworkPrediction = false; #Disable DNS prefetching
      PasswordManagerEnabled = false;
    };
    profiles.default = {
      isDefault = true;
      bookmarks = {
        force = true;
        settings = [];
      };
      extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
            bitwarden
            consent-o-matic
            vimium-c
        ];
      };
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
        "browser.tabs.inTitlebar" = 0;
	"sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "sidebar.main.tools" = ["history" "bookmarks"];
	"sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
	"browser.toolbarbuttons.introduced.sidebar-button" = true; # without explicitly enabling here, it gets put in the wrong place when configured below
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
  stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.firefox.colorTheme.enable = true;

}
