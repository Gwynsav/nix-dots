{ config }:

{
  # mpd configuration
  # -----------------
  services.mpd = {
    enable            = true;
    musicDirectory    = "${config.home.homeDirectory}/music";
    dataDir           = "${config.home.homeDirectory}/.config/mpd";
    extraConfig       = ''
      auto_update          "yes"
      auto_update_depth    "3"
      restore_paused       "yes"
      volume_normalization "yes"

      mixer_type           "software"
      audio_output {
        type               "pipewire"
        name               "PipeWire Sound Server"
        buffer_time        "100000"
      }
      audio_output {
        type               "fifo"
        name               "Visualizer"
        path               "/tmp/mpd.fifo"
        format             "44100:16:2"
      }

      connection_timeout   "15"
      max_connections      "8"
      max_playlist_length  "1024"
      '';
    network.startWhenNeeded = true;
  };
  
  # Allows mpd to work with playerctl.
  services.mpdris2.enable = true;
  # Discord RPC support
  services.mpd-discord-rpc = {
    enable   = true;
    settings = {
      hosts  = [ "localhost:6600" ];
      format = {
        details = "$title";
        state   = "By $artist on $album";
      };
    };
  };

  # Include ncmpcpp player configuration.
  imports = [ (import ./ncmpcpp.nix { inherit config; }) ];
}
