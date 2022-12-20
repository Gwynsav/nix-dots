# ---------------------------- #
# -- nix configuration file -- #
# ---------------------------- #

{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

    # Bootloader
    # ----------
    boot.loader.systemd-boot.enable      = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    # ----------
    networking.hostName                  = "fakeflake";
    networking.networkmanager.enable     = true;
    # networking.proxy.default = "https://user:password@proxy.port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # networking.firewall.enable           = true;
    # networking.firewall.allowedTCPPorts  = [ ... ];
    # networking.firewall.allowedUDPPorts  = [ ... ];

    # Locale
    # ------
    time.timeZone      = "Europe/Amsterdam";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font         = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    # Users
    # -----
    users.users.gw = {
      isNormalUser = true;
      extraGroups  = [ "wheel" ];
      packages     = with pkgs; [ ];
    };

    # X Server
    # --------
    services.xserver = {
      enable       = true;
      layout       = "us";
      xkbOptions   = "caps:super";
      # Touchpad support
      libinput.enable = true;
    };

    # Packages
    # --------
    environment.systemPackages = with pkgs; [
      vim
      git
      wget
      firefox
    ];

    # NixOS Settings
    # --------------
    # CUPS support
    services.printing.enable       = true;
    # Copy configuration.nix to /run/current-system/
    system.copySystemConfiguration = true;
    # Initial OS release.
    system.stateVersion            = "22.11";
}
