# ----------------------------------------------- #
# -- simple, privacy respecting firefox config -- #
# ----------------------------------------------- #

{ config, pkgs, nur, colors, ... }:

{
  programs.firefox = {
    enable     = true;
    extensions = with nur.repos.rycee.firefox-addons; [
      ublock-origin
      cookie-autodelete
      localcdn
      bitwarden
    ];
    # The first 4 'user_pref' enable CSS customization.
    # The rest are mostly privacy/security focused settings.
    profiles.gw = {
      id          = 0;
      userChrome  = import ./userChrome.nix { inherit colors; };
      extraConfig = ''
				user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
				user_pref("layers.acceleration.force-enabled", true);
				user_pref("gfx.webrender.all", true);
				user_pref("svg.context-properties.content.enabled", true);
				user_pref("browser.startup.homepage", "gwynsav.github.io/Bento");

				user_pref("doh-rollout.disable-heuristics", true);
				user_pref("dom.security.https_only_mode", true);
				user_pref("dom.security.https_only_mode_ever_enabled", true);
				user_pref("dom.security.https_only_mode_ever_enabled_pbm", true);
				user_pref("browser.contentblocking.category", "custom");
				user_pref("browser.discovery.enabled", false);
				user_pref("browser.formfill.enable", false);
				user_pref("browser.search.suggest.enabled", false);
				user_pref("browser.newtabpage.enabled", false);
				user_pref("places.history.enabled", false);
				user_pref("signon.autofillForms", false);
				user_pref("signon.generation.enabled", false);
				user_pref("signon.rememberSignons", false);

				user_pref("privacy.donottrackheader.enabled", true);
				user_pref("privacy.history.custom", true);
				user_pref("privacy.purge_trackers.date_in_cookie_database", 0);
				user_pref("privacy.sanitize.sanitizeOnShutdown", true);

				user_pref("datareporting.healthreport.uploadEnabled", false);
				user_pref("datareporting.policy");
				user_pref("network.dns.disablePrefetch", true);
				user_pref("network.predictor.enabled", false);
				user_pref("network.prefetch-next", false);

				user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
				user_pref("browser.urlbar.autoFill", false);
				user_pref("browser.urlbar.autocomplete.enabled", false);
				user_pref("browser.urlbar.suggest.bookmark", false);
				user_pref("browser.urlbar.suggest.history", false);
				user_pref("browser.urlbar.suggest.openpage", false);
				user_pref("browser.urlbar.suggest.searches", false);
				user_pref("browser.urlbar.suggest.topsites", false);
      '';
    };
  };
}
