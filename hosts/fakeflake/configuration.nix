# ------------------------------- #
# -- laptop configuration file -- #
# ------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "fakeflake";

  boot.kernelPackages = pkgs.linuxPackages_zen;
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
