{ pkgs, ... }: 
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableTelemetryForExtensionDeveloper = true;
      AllowYourOrganizationToSeeTelemetry = false;
      CrashReports = false;

      DisablePocket = true;
      Pocket = false;
      DisplayTopSites = true; # Keep the grid, but strip the junk below:
      
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
        TopSites = true;
        Highlights = false;
        SponsoredTopSites = false;
        SponsoredStories = false;
      };

      DisableFirefoxAccounts = false; # Set to true if you do not use Firefox Sync
      DisableFirefoxScreenshots = true;
      DisableFormHistory = true;
      OverrideFirstRunPage = ""; # Skip the annoying welcome/onboarding screens
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };

      Preferences = {
        "browser.pocket.enabled" = false;
        "browser.safebrowsing.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.search.suggest.enabled" = false; # Do not send keystrokes to search engines
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.speculativeConnect.enabled" = false; # Stop pre-resolving links
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.battery.enabled" = false; # Prevent tracking via battery status API
        "geo.enabled" = false;
        "loop.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-eme-adobe.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.ice.default_address_only" = true;
        "plugin.state.flash" = 0;
        "privacy.donatewithpaypal" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
      };
    };
  };
}
