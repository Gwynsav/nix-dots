# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
