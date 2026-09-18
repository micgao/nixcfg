{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    ./nvidia.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    inputs.nix-ld.nixosModules.nix-ld
    inputs.nix-index-database.nixosModules.default
  ];

  boot = {
    zswap.enable = true;
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
      kernelModules = [
        "i915"
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
    ];
  };

  systemd.user.services.telephony_client.enable = false;

  console = {
    colors = [
      "0F1014"
      "f58ee0"
      "8eb5f5"
      "9898a6"
      "c58fff"
      "fdfdfe"
      "ffbb88"
      "868690"
      "131317"
      "f58ee0"
      "8eb5f5"
      "9898a6"
      "c58fff"
      "fdfdfe"
      "ffbb88"
      "868690"
    ];
    useXkbConfig = true;
    earlySetup = false;
  };

  environment = {
    systemPackages = with pkgs; [
      gitFull
    ];
    shells = with pkgs; [ zsh nushell ];
  };

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        Hyprland = [
          "org.wezfurlong.wezterm.desktop"
          "kitty.desktop"
        ];
        default = [
          "org.wezfurlong.wezterm.desktop"
          "kitty.desktop"
        ];
      };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
        hyprland = {
          default = ["hyprland" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
      };
    };
  };

  security = {
    pam.services = {
      # greetd.enableGnomeKeyring = true;
      # login.enableGnomeKeyring = true;
      greetd.oo7.enable = true;
      login.oo7.enable = true;
    };
    run0 = {
      enable = true;
      wheelNeedsPassword = false;
      sudo-shim.enable = true;
      persistentAuth.enable = true;
    };
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = false;
  };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    # useUserPackages = true;
    users = { micgao = import ../home-manager; };
    backupFileExtension = "backup";
  };

  hardware = {
    i2c.enable = true;
    bluetooth = {
      enable = true;
      package = pkgs.bluez-experimental;
      settings = {
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          Experimental = true;
        };
      };
    };
    keyboard.qmk.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };
    enableRedistributableFirmware = true;
    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };

    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.new_feature;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "615.71.09";
        sha256_64bit = "sha256-zc7tIrvrYSSNGm3qvCWWZz46ZQFpjucayNL9wo87cP4=";
        openSha256 = "sha256-3gByMYIwFzRaLdDG+roCEOuKRRJDrljG9AlLnRZTirM=";
        settingsSha256 = "sha256-LK1LU8mDkM/XVRKPBtuOZh9nIP/lGFLAJnmasEX8jhg=";
        persistencedSha256 = "sha256-qPRb+3d88+2RcpUkoBTbjIaImnQ+jX+/6p1vXcJ5geE=";
      };
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      nvidiaPersistenced = false;
      videoAcceleration = true;
      powerManagement = {
        kernelSuspendNotifier = true;
      };
      moduleParams = {
        nvidia = {
          NVreg_UseKernelSuspendNotifiers = 1;
        };
        nvidia-drm = {
          color_pipeline = 0;
        };
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "/etc/nix/registry.json";
      warn-dirty = false;
      trusted-users = [ "@wheel" "micgao" ];
      use-xdg-base-directories = true;
    };
    channel.enable = false;
  };

  fonts = {
    packages = with pkgs; [
      liberation_ttf
      material-symbols
      noto-fonts
      noto-fonts-monochrome-emoji
      roboto
      roboto-mono
      roboto-flex
      inter
      cascadia-code
      (iosevka-bin.override { variant = "SS04"; })
    ];
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      enable = true;
      antialias = true;
      includeUserConf = true;
      defaultFonts = {
        monospace = [ "Iosevka SS04" ];
        sansSerif = [ "Inter" ];
        serif = [ "Inter" ];
        emoji = [ "Noto Emoji" ];
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    # libvirtd = {
    #   enable = true;
    # };
    virtualbox.host = {
      enable = true;
    };
  };

  networking = {
    wireless = {
      iwd ={
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
        };
      };
    };
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
    hostName = "X1E3";
    extraHosts = ''
      0.0.0.0 dota2.com
      0.0.0.0 www.dota2.com
      :: dota2.com
    '';
  };

  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_CA.UTF-8/UTF-8"
      "fr_CA.UTF-8/UTF-8"
    ];
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";

  services = {
    speechd.enable = false;
    oo7.enable = true;
    # ddccontrol = {
    #   enable = true;
    #   package = pkgs.ddcutil-service;
    # };
    tuned = {
      enable = true;
      ppdSupport = true;
      settings = {
        daemon = true;
        dynamic_tuning = false;
        reapply_sysctl = true;
      };
      recommend = {
        latency-performance = {};
      };
      ppdSettings = {
        main = {
          default = "performance";
          battery_detection = false;
        };
        profiles = {
          power-saver = "powersave";
          balanced = "balanced";
          performance = "latency-performance";
        };
      };
    };
    userborn = {
      enable = true;
      static = false;
      importLegacyState = false;
    };
    throttled.enable = true;
    # portmaster = {
    #   enable = true;
    #   stateDir = "/.rw-etc/upper/portmaster";
    # };
    scx-loader = {
      enable = true;
      config = {
        default_mode = "Auto";
      };
    };
    # mpdscribble = {
    #   enable = true;
    #   host = "127.0.0.1";
    #   port = 6600;
    #   endpoints = {
    #     "last.fm" = {
    #       passwordFile = "/home/micgao/.secrets/lastfm_password";
    #       username = "micgao";
    #     };
    #   };
    # };
    # fwupd.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    fstrim.enable = true;
    seatd.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${lib.getExe pkgs.tuigreet}";
        };
      };
      useTextGreeter = true;
    };
    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb = {
        model = "pc105";
        layout = "us,ca";
      };
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      socketActivation = true;
    };
    # btrfs.autoScrub = {
    #   enable = true;
    #   interval = "weekly";
    #   fileSystems = [
    #     "/nix"
    #     "/etc"
    #     "/var/log"
    #     "/root"
    #     "/home"
    #   ];
    # };
  };

  users = {
    users = {
      root = {
        initialHashedPassword = "$y$j9T$7lYt4bU0tDXwtmZO.3HRt.$Of4bHRuscOWvNYpJBcIOvVpuzNuXHCGGb32/.k5vKXC";
      };
      greeter = {
        extraGroups = [
          "seat"
        ];
      };
      micgao = {
        initialHashedPassword = "$y$j9T$nLDJJCXXgnqjj/ApXu7Ov1$Ztk6yzFzuZnEhyulNaQhXxNTbBHTHSL6JmDL4X/Cju5";
        shell = pkgs.nushell;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "vboxusers"
          "podman"
          "kvm"
          "rtkit"
          "plugdev"
          "networkmanager"
          "i2c"
        ];
      };
    };
  };

  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    nix-index-database = {
      enable = true;
      comma.enable = true;
    };
    obs-studio.enable = true;
    # virt-manager.enable = true;
    dconf.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    seahorse.enable = true;
    steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
      ];
      gamescopeSession = {
        enable = true;
        args = [
          "--steam"
          "--rt"
          "-W 1920"
          "-H 1080"
          "-r 144"
          "--adaptive-sync"
        ];
      };
    };
    nix-ld.dev.enable = true;
    gamescope = {
      enable = true;
      enableWsi = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  qt = {
    enable = true;
  };

  system = {
    stateVersion = "23.11";
    nixos-init.enable = true;
    etc.overlay = {
      enable = true;
      mutable = true;
    };
  };
}
