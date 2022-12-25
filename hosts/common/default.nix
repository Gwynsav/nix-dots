# ------------------------------ #
# -- common nix configuration -- #
# ------------------------------ #

{ config, pkgs, lib, ... }:

{
  # Enable the usage of flakes, pretty important for git versions
  # of Awesome and Picom.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  # ----------
  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  # ----------
  networking.networkmanager.enable     = true;
  networking.firewall.enable           = true;

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
    extraGroups  = [ "wheel" "networkmanager" "audio" ];
    packages     = with pkgs; [ ];
  };

  # Shell
  # -----
  users.defaultUserShell = pkgs.zsh;

  # X Server
  # --------
  services = {
    xserver = {
      enable       = true;
      layout       = "us";
      xkbOptions   = "caps:super";
      # Touchpad support
      libinput.enable = true;
      displayManager = {
        lightdm = {
          enable     = true;
          background = ./stuff/lightdm_bg.png;
        };
        defaultSession = "none+awesome";
      };
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
    pipewire = {
      enable       = true;
      jack.enable  = true;
      pulse.enable = true;
      alsa = {
        enable       = true;
        support32Bit = true;
      };
    };
  };
  systemd.user.services = {
    pipewire.wantedBy       = [ "default.target" ];
    pipewire-pulse.wantedBy = [ "default.target" ];
  };

  # Packages
  # --------
  # Some default system packages. GUI apps can be found in the
  # per user configurations at `users/USERNAME/home.nix` and per
  # host configurations.
  nixpkgs.config.allowUnfree = true;
  environment = {
    binsh  = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      vim
      lf
      wget
      htop
      pfetch
      lua
    ];
  };

  # Qt / GTK
  # --------
  programs.dconf.enable = true;
  qt5 = {
    enable        = true;
    platformTheme = "gtk2";
    style         = "gtk2";
  };

  # Fonts
  # -----
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      material-icons
      ( nerdfonts.override { fonts = [ "CascadiaCode" ]; } )
    ];
    fontconfig.enable = true;
  };

  # Hardware
  # --------
  # CUPS support
  services.printing.enable = true;
  # Bluetooth
  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = false;
  };

  # NixOS Settings
  # --------------
  # Copy configuration.nix to /run/current-system/
  system.copySystemConfiguration = true;
  # Initial OS release.
  system.stateVersion            = "22.11";
}
