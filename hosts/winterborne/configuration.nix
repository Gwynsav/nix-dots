# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  # Packages
  # --------
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  environment = {
    systemPackages = with pkgs; [
      openrgb
      piper
      heroic
      steam
      protonup
    ];
    sessionVariables = rec {
      # This is where custom Proton versions go.
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  # Drivers and Login
  # -----------------
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager = {
      autoLogin = {
        enable  = true;
        user    = "gw";
        timeout = 0;
      };
      lightdm.greeter = false;
  };
  hardware.opengl = {
    enable          = true;
    driSupport      = true;
    driSupport32Bit = true;
  };

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
