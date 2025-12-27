{ inputs, outputs, lib, pkgs, ... }:
{

   programs.home-manager.enable = true;

   programs.git = {
     enable = true;
     settings.user = {
       name = "Kevin Sladowski";
       email = "ksladowski@mailbox.org";
     };
   };

  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        bitwarden
        consent-o-matic
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
          bing.metadata.hidden = true;
        };
      };
      settings = {
        "browser.startup.homepage" = "about:home";

        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

	# Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "extensions.getAddons.showRecommendations" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        "browser.dataFeatureRecommendations.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.topsites" = false;
     
        "browser.toolbars.bookmarks.visibility" = "never";


        "extensions.autoDisableScopes" = 0;

        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # Remove close button
        "browser.tabs.inTitlebar" = 0;
        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "sidebar.revamp" = true;
	"sidebar.main.tools" = ["history" "bookmarks"];
	# Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            nav-bar = ["sidebars" "back-button" "forward-button" "vertical-spacer" "stop-reload-button" "urlbar-container" "downloads-button" "unified-extensions-button"];
            toolbar-menubar = ["menubar-items"];
            vertical-tabs = ["tabbrowser-tabs"];
          };
        };
      };
    };
  };

  home = {
    packages = with pkgs; [
      emacs
      bitwarden-desktop
      bitwarden-cli
   ];
   
   username = "kevin";
   homeDirectory = "/home/kevin";

   stateVersion = "23.11";
  };
}
