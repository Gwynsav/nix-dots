# ---------------------------- #
# -- nix configuration file -- #
# ---------------------------- #

{ config, pkgs, lib, ... }:

{
  # Enable the usage of flakes, pretty important for Awesome and Picom.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
  ];

  # TODO:
  # get XServer + Awesome-git going.

  # Bootloader
  # ----------
  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  # ----------
  networking.hostName                  = "fakeflake";
  networking.networkmanager.enable     = true;
  # networking.proxy.default = "https://user:password@proxy.port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.firewall.enable           = true;
  # networking.firewall.allowedTCPPorts  = [ ... ];
  # networking.firewall.allowedUDPPorts  = [ ... ];

  # Security
  # --------
  # doas is a smaller, more secure implementation of sudo.
  security.sudo.enable = false;
  security.doas = {
    enable     = true;
    extraRules = [
      {
        users   = [ "gw" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

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
    # Since doas is bound to gw in specific, there's no need for the
    # wheel group. This wouldn't be the case for sudo though.
    # extraGroups  = [ "wheel" ];
    packages     = with pkgs; [ ];
  };

  # X Server
  # --------
  services.xserver = {
    # Disabled for the time being ;)
    enable       = true;
    layout       = "us";
    xkbOptions   = "caps:super";
    # Touchpad support
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    windowManager.awesome = {
      enable     = true;
      luaModules = lib.attrValues {
        inherit (pkgs.luaPackages)
         lgi ldbus luadbi-mysql luaposix;
      };
    };
  };
  
  # Sound
  # -----
  # We do Pipewire 'round here.
  services.pipewire.enable       = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable  = true;
  # We also do some plumbin'
  # Note: Wireplumber is actually the default session manager. I just
  # put this here for it to be more explicit.
  services.pipewire.wireplumber.enable = true;

  # Packages
  # --------
  # Some default system packages. More specific is stuff is found in the
  # per user configurations at `users/USERNAME/home.nix`
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    firefox
    neofetch
  ];

  # Fonts
  # -----
  fonts.fonts = with pkgs; [
    noto-fonts
    material-icons
    ( nerdfonts.override { fonts = [ "CascadiaCode" ]; } )
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
