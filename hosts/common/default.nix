# ------------------------------ #
# -- common nix configuration -- #
# ------------------------------ #

{ pkgs, overlays, lib, ... }:

{
  # Bootloader
  # ----------
  boot = {
    cleanTmpDir = true;
    loader = {
      grub = {
        enable      = true;
        version     = 2;
        device      = "nodev";
        # Custom entries for dualbooting.
        useOSProber = true;
        efiSupport  = true;
        extraEntries = ''
          menuentry "UEFI BIOS" --id 'uefi-firmware' {
            fwsetup
          }
          menuentry "Reboot" {
            echo "System rebooting..."
            reboot
          }
          menuentry "Shutdown" {
            echo "System shutting down..."
            halt
          }
        '';
        splashImage = null;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint     = "/boot";
      };
      # Infinite grub timeout.
      timeout       = null;
    };
  };

  # Networking
  # ----------
  networking = {
    networkmanager.enable  = true;
    firewall.enable        = true;
  };

  # Security
  # --------
  # doas is a smaller, more secure implementation of sudo.
  security = {
    sudo.enable = false;
    doas = {
      enable      = true;
      extraRules  = [
        {
          users   = [ "gw" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  # Locale
  # ------
  time = {
    hardwareClockInLocalTime = true;
    timeZone                 = "Europe/Amsterdam";
  };
  i18n.defaultLocale  = "en_US.UTF-8";
  console = {
    font          = "Lat2-Terminus16";
    useXkbConfig  = true;
  };

  # Users
  # -----
  users = {
    users.gw = {
      isNormalUser  = true;
      extraGroups   = [ "wheel" "networkmanager" "audio" "video" "libvirtd" ];
      packages      = with pkgs; [ ];
    };
    defaultUserShell = pkgs.stable.bash;
  };

  # X Server
  # --------
  services = {
    xserver = {
      enable      = true;
      layout      = "us";
      xkbOptions  = "caps:super";
      libinput = {
        # Touchpad support
        enable             = true;
        # Disable mouse *ONLY* acceleration.
        mouse.accelProfile = "flat";
      };
      displayManager  = {
        # lightdm = {
        #   enable      = true;
        #   background  = ./stuff/lightdm_bg.png;
        # };
        sddm.enable    = true;
        defaultSession = "none+awesome";
      };
      windowManager.awesome = {
        enable      = true;
        luaModules  = lib.attrValues {
          inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
        };
      };
    };
    # Sound
    # -----
    # Pipewire good.
    pipewire = {
      enable        = true;
      # Compatibility with other sound interfaces.
      jack.enable   = true;
      pulse.enable  = true;
      alsa  = {
        enable        = true;
        support32Bit  = true;
      };
    };
  };
  systemd.user.services = {
    pipewire.wantedBy       = [ "default.target" ];
    pipewire-pulse.wantedBy = [ "default.target" ];
  };

  # Virtualization
  # --------------
  # In virt-manager, add a new connection with default settings.
  virtualisation = {
    libvirtd.enable = true;
    # resolution      = { x = 1920; y = 1080; };
    # sharedDirectories = {
    #   shared-dir = {
    #     source = "/home/gw/shared";
    #     target = "/mnt/shared";
    #   };
    # };
  };

  # Packages
  # --------
  # Some default system packages. GUI apps can be found in the
  # per user configurations at `users/USERNAME/home.nix` and per
  # host configurations at `hosts/HOSTNAME/configuration.nix`.
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = lib.attrValues {
      inherit (pkgs.stable)
        # languages/compilers
        cmake gcc lua
        # utils
        git wget unzip exa 
        # screenshooting
        shotgun hacksaw xclip
        # misc
        libnotify pulseaudio
        home-manager virt-manager;

      inherit (pkgs.unstable)
        emacs
        hilbish;
    } ++ [ (lib.hiPrio pkgs.stable.procps) ];
    binsh  = "${pkgs.bash}/bin/bash";
    shells = [ "${pkgs.unstable.hilbish}/bin/hilbish" ];
    shellAliases = {
      sudo     = "doas";
      ls       = "exa -l";
      emacs    = "emacs &";
      nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
    };
    variables = {
      EDITOR  = "${pkgs.emacs}/bin/emacs";
      VISUAL  = "${pkgs.emacs}/bin/emacs";
      BROWSER = "${pkgs.firefox}/bin/firefox";
    };
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
    fonts = lib.attrValues {
      # It's convenient to install fonts as unstable packages.
      # Some of them aren't available on the stable channel.
      inherit (pkgs.unstable)
        roboto
        fira-code
        eb-garamond
        material-icons
        noto-fonts-emoji-blob-bin;
    } ++ [( pkgs.stable.nerdfonts.override { fonts = [ "CascadiaCode" ]; } )];
    fontconfig = {
      enable        = true;
      defaultFonts  = {
        serif     = [ "EB Garamond" ];
        sansSerif = [ "Roboto" ];
        emoji     = [ "Blobmoji" ];
        # CascadiaCode has a very weird fc name.
        monospace = [ "Fira Code" ];
      };
    };
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
  nix = {
    settings = {
      # Enable the usage of flakes, pretty important for git versions
      # of Awesome and Picom provided by fortuneteller2k, as well as NUR.
      experimental-features = [ "nix-command" "flakes" ];
      # Trust users in wheel to connect to the Nix daemon.
      trusted-users         = [ "root" "@wheel" ];
      # Nix-store cleanup.
      auto-optimise-store   = true;
    };
    # Automatic maintenance.
    gc = {
      automatic = true;
      options   = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };
  system = {
    # Copy configuration.nix to /run/current-system/
    # I found out way too late this is entirely incompatible
    # with flakes, and therefore this whole configuration :/
    copySystemConfiguration = false;
    # OS release at time of installation.
    stateVersion            = "22.11";
  };
}
