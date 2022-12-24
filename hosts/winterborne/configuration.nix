# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  environment.systemPackages = [
    openrgb
    piper
    heroic
    steam
  ];

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
