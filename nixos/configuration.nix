{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    inputs.nix-ld.nixosModules.nix-ld
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
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
      kernelModules = [
        "nvidia"
      ];
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
    ];
    modprobeConfig.enable = true;
    extraModulePackages = [
      config.boot.kernelPackages.nvidia_x11
    ];
  };

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
    ];
    etc = lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
    config.nix.registry;
    sessionVariables = {
      LIBSEAT_BACKEND = "logind";
      NIXOS_OZONE_WL = "1";
    };
    shells = with pkgs; [ zsh nushell ];
  };

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        Hyprland = [
          "kitty.desktop"
          "org.wezfurlong.wezterm.desktop"
        ];
        default = [
          "kitty.desktop"
          "org.wezfurlong.wezterm.desktop"
        ];
      };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config = {
        common.default = ["gtk"];
        hyprland = {
          default = ["gtk" "hyprland"];
        };
      };
    };
  };

  security = {
    pam.services = {
      greetd.enableGnomeKeyring = true;
    };
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
    rtkit.enable = true;
    polkit.enable = true;
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
      branch = "new_feature";
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.new_feature;
      modesetting.enable = true;
      videoAcceleration = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
    {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        flake-registry = "/etc/nix/registry.json";
        keep-going = true;
        keep-outputs = true;
        keep-derivations = true;
        warn-dirty = false;
        nix-path = config.nix.nixPath;
        trusted-users = [ "root" "@wheel" "micgao" ];
        use-xdg-base-directories = true;
      };
      channel.enable = false;
      # gc = {
      #   automatic = true;
      #   dates = "weekly";
      #   options = "--delete-older-than 14d";
      # };
      registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs;
      nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    };

  fonts = {
    enableDefaultPackages = false;
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
      cache32Bit = true;
      includeUserConf = true;
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      hinting = {
        enable = true;
      };
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
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    useNetworkd = true;
    useDHCP = true;
    wireguard = {
      enable = true;
    };
    wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
        };
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
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Toronto";

  services = {
    thermald = {
      enable = true;
      ignoreCpuidCheck = true;
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
      };
    };
    flatpak.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [
        "--autopower"
        "--per-cpu-dsq"
        "--enable-cpu-bw"
      ];
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
      packages = with pkgs; [ gcr gnome-keyring ];
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${lib.getExe pkgs.tuigreet} --time --asterisks";
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
    users.micgao = {
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
      ];
    };
  };

  programs = {
    gpu-screen-recorder.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    # virt-manager.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    steam = {
      enable = true;
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
    zsh.enable = true;
  };

  qt = {
    enable = true;
  };

  system = {
    stateVersion = "23.11";
  };
}
