# -------------------------------- #
# -- Home Manager Configuration -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

let
  # Nix User Repository
  nur = import (builtins.fetchTarball {
    url    = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0my2286bzk8jhmhjvas61fbk31p43s3xd3rz4q6qc5vl1afd3641";
  }) { inherit pkgs; };

  # Colorscheme
  colors      = import ./theme/decay.nix {};
  decayce-gtk = with pkgs; callPackage ../../pkgs/decayce-gtk.nix { };
in

{
  # HomeManager Variables
  # ---------------------
  programs.home-manager.enable = true;

  # Program Configurations
  # ----------------------
  # TODO: correct neovim file structure
  xdg.configFile.nvim.source    = ./config/shell/nvim;
  xdg.configFile.awesome.source = ./config/gwdawful;

  imports = [
    # Terminal Emulators
    # By default these dots use XTerm, as Nix installs it as a fallback,
    # you may still add whichever of the following on top of that.
    # ( import ./config/terms/kitty      { inherit colors; } )
    ( import ./config/terms/alacritty  { inherit colors; } )

    # Terminal Apps
    ( import ./config/shell/zsh        { inherit config; } )
    ( import ./config/shell/nvim       { inherit pkgs; } )
    ( import ./config/shell/htop       { inherit config; } )
    ( import ./config/shell/lf         { } )

    # GUI Apps
    ( import ./config/utils/rofi       { inherit config colors; } )
    ( import ./config/utils/zathura    { inherit colors; } )
    ( import ./config/browser/firefox  { inherit colors nur; } )
    ( import ./config/browser/discocss { inherit colors; } )

    # Music
    ( import ./config/music/mpd        { inherit config; } )
    ( import ./config/music/ncmpcpp    { inherit config; } )

    # Miscelaneous
    ( import ./config/xresources.nix   { inherit colors; } )
    # ( import ./config/utils/picom      { inherit colors; } )
  ];

  # Enable some useful programs.
  programs.mpv.enable        = true;

  # GTK Configuration
  # -----------------
  gtk = {
    enable     = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    theme.name = "Decayce";
    iconTheme  = with pkgs; {
      name    = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };

  home = {
    # Package Installations
    # ---------------------
    packages = with pkgs; [
      playerctl
      xfce.thunar
      feh
      decayce-gtk
      gnome.gucharmap
      gpick
    ];

    # Environment Variables
    # ---------------------
    sessionVariables = {
      BROWSER       = "${pkgs.firefox}/bin/firefox";
      EDITOR        = "${pkgs.neovim}/bin/nvim";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    };
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    # Files
    # -----
    file = {
      ".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
      ".local/bin/fetch" = {
        executable = true;
        text       = import ./bin/fetch.nix { };
      };
      ".local/bin/panes" = {
        executable = true;
        text       = import ./bin/panes.nix { };
      };
    };
  };

  # XDG Configuration
  # -----------------
  xdg = {
    enable   = true;
    userDirs = {
      enable   = true;
      pictures = "${config.home.homeDirectory}/Pictures";
      music    = "${config.home.homeDirectory}/Music";
    };
  };
}
