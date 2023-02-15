# ------------------------------- #
# -- laptop configuration file -- #
# ------------------------------- #

{ pkgs, lib, ... }:

{
  networking.hostName = "fakeflake";

  # Packages
  # --------
  boot.kernelPackages = pkgs.stable.linuxPackages_zen;
  environment.systemPackages = lib.attrValues {
    inherit (pkgs.stable)
      brightnessctl;
  };

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
