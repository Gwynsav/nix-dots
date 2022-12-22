# ------------------------------- #
# -- laptop configuration file -- #
# ------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "fakeflake";

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
