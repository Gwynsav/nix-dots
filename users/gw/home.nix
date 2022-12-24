{ config, pkgs, lib, ... }:

let
  nur = import (builtins.fetchTarball {
    url    = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0my2286bzk8jhmhjvas61fbk31p43s3xd3rz4q6qc5vl1afd3641";
  }) { inherit pkgs; };
  colors = import ./theme/tokyonight.nix {};
in

{
  # Home Manager variables
  # ----------------------
  home.username      = "gw";
  home.homeDirectory = "/home/gw";
  # It is not necessary to change this with updates.
  home.stateVersion            = "22.11";
  programs.home-manager.enable = true;

  # Program Configurations
  # ----------------------
  # TODO: correct neovim file structure
  xdg.configFile.nvim.source    = ./config/nvim;
  xdg.configFile.awesome.source = ./config/awesome;
  xdg.configFile.lf.source      = ./config/lf;

  imports = [
    # ( import ./config/picom   { inherit pkgs; } )
    ( import ./config/kitty   { inherit pkgs colors; } )
    ( import ./config/zathura { inherit pkgs colors; } )
    ( import ./config/nvim    { inherit pkgs config lib; } )
    ( import ./config/rofi    { inherit pkgs config lib colors; } )
    ( import ./config/firefox { inherit pkgs config colors nur; } )
  ];

  # Enable some useful programs.
  fonts.fontconfig.enable    = true;
  services.playerctld.enable = true;

  # Package Installations
  # ---------------------
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    lua
    maim
    xclip
    xfce.thunar
    feh
    gnome.gucharmap
  ];
}
