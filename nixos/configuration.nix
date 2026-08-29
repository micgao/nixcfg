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
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
    ];
  };
  
  systemd.network.wait-online.enable = false;

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
    sessionVariables = {
      LIBSEAT_BACKEND = "logind";
    };
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
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
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
      greetd.enableGnomeKeyring = true;
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
    keyboard.qmk.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
      ];
    };
    enableRedistributableFirmware = true;
    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };

    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.new_feature;
      modesetting.enable = true;
      videoAcceleration = true;
      powerManagement = {
        kernelSuspendNotifier = true;
      };
      moduleParams = {
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "/etc/nix/registry.json";
      warn-dirty = false;
      trusted-users = [ "root" "@wheel" "micgao" ];
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
      source-code-pro
      source-sans-pro
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
    dhcpcd.wait = "background";
    wireless = {
      iwd.enable = true;
    };
    networkmanager = {
      insertNameservers = [
        "1.1.1.1#one.one.one.one"
        "9.9.9.9#dns.quad9.net"
      ];
      enable = true;
      dns = "systemd-resolved";
      dhcp = "dhcpcd";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    hostName = "X1E3";
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
    portmaster.enable = true;
    lact.enable = true;
    resolved = {
      enable = true;
      settings.Resolve.DNSOverTLS = "opportunistic";
    };
    upower = {
      enable = true;
    };
    tuned = {
      enable = true;
      ppdSupport = true;
      settings = {
        daemon = true;
        dynamic_tuning = true;
        reapply_sysctl = false;
      };
    };
    flatpak.enable = true;
    scx-loader = {
      enable = true;
      config = {
        default_mode = "Auto";
      };
    };
    mpdscribble = {
      enable = true;
      host = "127.0.0.1";
      port = 6600;
      endpoints = {
        "last.fm" = {
          passwordFile = "/home/micgao/.secrets/lastfm_password";
          username = "micgao";
        };
      };
    };
    hardware.bolt.enable = true;
    fwupd.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ gcr gnome-settings-daemon ];
      implementation = "broker";
    };
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    logind.settings.Login = {
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitch = "ignore";
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
      extraConfig = {
        pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
        pipewire-pulse."92-low-latency" = {
          "context.properties" = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = { };
            }
          ];
          "pulse.properties" = {
            "pulse.min.req" = "32/48000";
            "pulse.default.req" = "32/48000";
            "pulse.max.req" = "32/48000";
            "pulse.min.quantum" = "32/48000";
            "pulse.max.quantum" = "32/48000";
          };
          "stream.properties" = {
            "node.latency" = "32/48000";
            "resample.quality" = 1;
          };
        };
      };
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
    # };
  };

  users = {
    defaultUserShell = pkgs.bashInteractive;
    users = {
      greeter = {
        extraGroups = [
          "seat"
        ];
      };
      micgao = {
        shell = pkgs.nushell;
        isNormalUser = true;
        extraGroups = [
          "i2c"
          "wheel"
          "video"
          "audio"
          "input"
          "vboxusers"
          "podman"
          "kvm"
          "rtkit"
          "networkmanager"
        ];
      };
    };
  };

  programs = {
    nix-index-database = {
      enable = true;
      comma.enable = true;
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    # virt-manager.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    steam = {
      enable = true;
      extraPackages = [
        pkgs.gamescope
      ];
      gamescopeSession = {
        enable = true;
        steamArgs = [
          "-pipewire-dmabuf"
          "-dev"
          "-console"
        ];
        args = [
          "--steam"
          "--rt"
          "-W 1920"
          "-H 1080"
          "-r 144"
          "--expose-wayland"
          "--xwayland-count 2"
          "--adaptive-sync"
          "--prefer-output HDMI-A-1"
          "--prefer-vk-device 10de:1f95"
          "--immediate-flips"
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
  };
}
