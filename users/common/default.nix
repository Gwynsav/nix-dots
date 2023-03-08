{ config, pkgs, lib, colors, ... }:

let
  # Nix User Repository
  nur = import (builtins.fetchTarball {
    url    = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0my2286bzk8jhmhjvas61fbk31p43s3xd3rz4q6qc5vl1afd3641";
  }) { inherit pkgs; };
in

{
  # Allows Home Manager to administer itself.
  programs.home-manager.enable = true;

  home = {
    # Environment Variables
    # ---------------------
    sessionVariables.XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    # Files
    # -----
    file = {
      ".local/bin/fetch" = {
        executable = true;
        text       = import ./bin/fetch.nix { };
      };
      ".local/bin/panes" = {
        executable = true;
        text       = import ./bin/panes.nix { };
      };
      ".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
    };

    # Common Packages
    # ---------------
    packages = lib.attrValues {
      inherit (pkgs.stable)
        # image editing & viewing
        gimp inkscape mpv feh
        # utils
        tageditor gpick usbimager;

      inherit (pkgs.unstable)
        # mc
        prismlauncher;
    } ++ [
      # GTK themes
      pkgs.catppuccin-gtk

      # Extra utils
      pkgs.stable.gnome.gucharmap
      pkgs.stable.cinnamon.nemo
    ];
  };
  
  # XDG User Directories
  # --------------------
  xdg = {
    enable   = true;
    userDirs = {
      enable   = true;
      pictures = "${config.home.homeDirectory}/Pictures";
      music    = "${config.home.homeDirectory}/Music";
    };
  };

  # Common Programs
  # ---------------
  imports = [
    # Music
    ( import ./config/music/mpd        { inherit pkgs config; } )
    ( import ./config/music/ncmpcpp    { inherit config; } )
    ( import ./config/utils/yt-dlp     { inherit pkgs; } )

    # Shell Utilities
    ( import ./config/shell/htop       { inherit config; } )
    ( import ./config/shell/lf         { } )

    # GUI Apps
    # ( import ./config/utils/rofi       { inherit config colors; } )
    ( import ./config/utils/zathura    { inherit colors; } )
    ( import ./config/browser/discocss { inherit colors; } )

    # Miscelaneous
    ( import ./config/xresources.nix   { inherit colors; } )
    ( import ./config/utils/picom      { inherit colors; } )
  ];
}
