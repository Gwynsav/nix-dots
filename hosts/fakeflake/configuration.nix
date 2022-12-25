# ------------------------------- #
# -- laptop configuration file -- #
# ------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "fakeflake";

  # Packages
  # --------
  boot.kernelPackages = pkgs.linuxPackages_zen;
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  # Power
  # -----
  services = {
    tlp.enable    = true;
    upower.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
