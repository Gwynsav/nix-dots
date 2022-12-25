# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ config, pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  hardware.opengl = {
    enable          = true;
    driSupport      = true;
    driSupport32Bit = true;
  };

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

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager = {
      defaultSession = "none+awesome";
      autoLogin = {
        enable  = true;
        user    = "gw";
        timeout = 0;
      };
      lightdm.greeter = false;
  };

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
