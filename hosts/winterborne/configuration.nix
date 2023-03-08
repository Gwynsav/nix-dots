# -------------------------------- #
# -- desktop configuration file -- #
# -------------------------------- #

{ pkgs, lib, ... }:

{
  networking.hostName = "winterborne";

  # Boot & Kernel
  # -------------
  boot = {
    kernelPackages = pkgs.unstable.linuxPackages_zen;
    kernelModules  = [ "i2c-dev" "i2c-piix4" ];
    loader = {
      grub = {
        # Custom entries for dualbooting.
        useOSProber = true;
        efiSupport  = true;
      };
      # Infinite grub timeout.
      timeout       = null;
    };
  };

  # Drivers 
  # -------
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      dpi          = 96;
    };
  };
  hardware.opengl = {
    enable          = true;
    driSupport      = true;
    driSupport32Bit = true;
  };

  # Packages
  # --------
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

  imports = [
    ./hardware-configuration.nix
    ../common
  ];
}
