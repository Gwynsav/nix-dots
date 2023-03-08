# ----------------------------------------------- #
# -- mpdris2 + discord-rpc + playerctl support -- #
# ----------------------------------------------- #

{ pkgs, ... }:

{
  # Allows mpd to work with playerctl.
  home.packages = [ pkgs.stable.playerctl ];
  services.mpdris2.enable    = true;
  services.playerctld.enable = true;
  # Discord RPC support
  services.mpd-discord-rpc = {
    enable   = true;
    settings = {
      hosts  = [ "localhost:6600" ];
      format = {
        details     = "$title";
        state       = "By $artist on $album ($date)";
        large_image = "url";
        small_image = "url";
      };
    };
  };
}
