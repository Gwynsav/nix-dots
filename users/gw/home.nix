{ config, pkgs, lib, ... }:

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
  xdg.configFile.awesome.source = ./config/awesome;
  xdg.configFile.rofi.source    = ./config/rofi;
  xdg.configFile.lf.source      = ./config/lf;
  xdg.configFile.zathura.source = ./config/zathura;
  # xdg.configFile.picom.source   = ./config/picom;
  # TODO: correct neovim file structure
  xdg.configFile.nvim.source    = ./config/nvim;

  imports = [
    ( import ./config/kitty { inherit pkgs; } )
    ( import ./config/nvim  { inherit pkgs config lib; } )
  ];

  # Enable some useful programs.
  fonts.fontconfig.enable    = true;
  programs.rofi.enable       = true;
  services.playerctld.enable = true;

  # Package Installations
  # ---------------------
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox
    lua
    maim
    xclip
    xfce.thunar
    zathura
    picom
    feh
    gnome.gucharmap
  ];
}
