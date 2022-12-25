{ config, pkgs, lib, ... }:

let
  nur = import (builtins.fetchTarball {
    url    = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0my2286bzk8jhmhjvas61fbk31p43s3xd3rz4q6qc5vl1afd3641";
  }) { inherit pkgs; };
  colors = import ./theme/decay.nix {};
  decayce-gtk = with pkgs; callPackage ../../pkgs/decayce-gtk.nix { };
in

{
  # HomeManager Variables
  # ----------------------
  home = {
    username      = "gw";
    homeDirectory = "/home/gw";
    stateVersion  = "22.11";
  };
  programs.home-manager.enable = true;

  # Program Configurations
  # ----------------------
  # TODO: correct neovim file structure
  xdg.configFile.nvim.source    = ./config/nvim;
  xdg.configFile.awesome.source = ./config/awesome;
  xdg.configFile.lf.source      = ./config/lf;

  imports = [
    ( import ./config/nvim    { inherit pkgs config lib; } )

    ( import ./config/zsh     { inherit pkgs config; } )
    ( import ./config/kitty   { inherit pkgs colors; } )
    # ( import ./config/picom   { inherit pkgs colors; } )

    ( import ./config/zathura { inherit pkgs colors; } )
    ( import ./config/rofi    { inherit pkgs config lib colors; } )
    ( import ./config/firefox { inherit pkgs config colors nur; } )

    ( import ./config/mpd     { inherit config; } )
  ];

  # Enable some useful programs.
  services.playerctld.enable = true;
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

  nixpkgs.config.allowUnfree = true;
  home = {
    # Package Installations
    # ---------------------
    packages = with pkgs; [
      maim
      xclip
      xfce.thunar
      feh
      decayce-gtk
      # le ricing tools
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
    };
  };

  # XDG Configuration
  # -----------------
  xdg = {
    enable   = true;
    userDirs = {
      enable   = true;
      pictures = "${config.home.homeDirectory}/Pictures";
    };
  };
}
