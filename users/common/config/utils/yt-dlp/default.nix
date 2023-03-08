{ pkgs, ... }:

{
  programs.yt-dlp = {
    enable    = true;
    package   = pkgs.unstable.yt-dlp;
    settings  = {
      extract-audio   = true;
      audio-quality   = 3;
      audio-format    = "mp3";
      embed-metadata  = true;
      embed-thumbnail = true;
      output          = "'~/Music/%(artist)s/%(album)s/%(playlist_index)s - %(title)s.%(ext)s'";
    };
    extraConfig     = ''
      --parse-metadata "title:%(artist)s - %(title)s"
      --parse-metadata "playlist_index:%(track_number)s";
    '';
  };
}
