{ config, pkgs, lib, ... }:

{
  # Home Manager variables.
  home.username      = "gw";
  home.homeDirectory = "/home/gw";
  # It is not necessary to change this with updates.
  home.stateVersion            = "22.11";
  programs.home-manager.enable = true;

  xdg.configFile.awesome.source = ./config/awesome;
  xdg.configFile.rofi.source    = ./config/rofi;

  # Enable some useful programs.
  fonts.fontconfig.enable    = true;
  programs.rofi.enable       = true;
  services.playerctld.enable = true;

  # Package Installations.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    kitty
    neovim
    lua
    maim
    xclip
    playerctl
    xfce.thunar
    picom
  ];
}
