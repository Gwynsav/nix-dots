# ------------------------------- #
# -- laptop configuration file -- #
# ------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "fakeflake";

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  # Power Settings
  services = {
    tlp.enable    = true;
    upower.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
