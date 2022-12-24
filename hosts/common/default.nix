# ------------------------------ #
# -- common nix configuration -- #
# ------------------------------ #

{ config, pkgs, lib, ... }:

{
  # Enable the usage of flakes, pretty important for Awesome and Picom.
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

  # Shell
  # -----
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable    = true;
    syntaxHighlighting.enable = true;
  };
  programs.starship = {
    enable   = true;
    settings = {
      format = "$cmd_duration$directory$git_branch$git_status\n[ ](fg:blue) ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout   = 2;
    };
  };

  # X Server
  # --------
  services = {
    xserver = {
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
  # per user configurations at `users/USERNAME/home.nix`
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
    ];
    variables = {
      TERM   = "kitty";
      EDITOR = "nvim";
    };
  };

  # Fonts
  # -----
  fonts.fonts = with pkgs; [
    noto-fonts
    material-icons
    ( nerdfonts.override { fonts = [ "CascadiaCode" ]; } )
  ];

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
