# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  # Packages
  # --------
  boot.kernelPackages = pkgs.unstable.linuxPackages_zen;
  environment = {
    systemPackages = lib.attrValues {
      inherit (pkgs.stable)
        piper;

      inherit (pkgs.unstable)
        openrgb
        heroic
        steam
        protonup-ng;
    };
    sessionVariables = rec {
      # This is where custom Proton versions go.
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  # Drivers 
  # -------
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    dpi          = 96;
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
