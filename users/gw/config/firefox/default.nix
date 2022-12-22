{ config, pkgs, nur, ... }:
{
  programs.firefox = {
    enable    = true;
    extension = with nur.repos.rycee.firefox-addons; [
      ublock-origin
      cookie-autodelete
      localcdn
      bitwarden
    ];
    profiles.gw = {
      id          = 0;
      userChrome  = import ./userChrome.nix;
      extraConfig = ''
        user_pref("browser.urlbar.autoFill", false);
	user_pref("layers.acceleration.force-enabled", true);
        user_pref("toolkit.legacyUserProfileCustomization.stylesheets", true);
	user_pref("gfx.webrender.all", true);
	user_pref("svg.context-properties.content.enabled", true);
      '';
    };
  };
}
