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
    bootspec = {
      enable = true;
    };
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];
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
      enable = true;
      includeDefaultModules = true;
      verbose = false;
      systemd = {
        enable = true;
        network.wait-online.enable = false;
        dbus.enable = true;
      };
    };
    modprobeConfig.enable = true;
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
    '';
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
      libnotify
      libsecret
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
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };
    };
  };

  security = {
    pam.services = {
      hyprlock = { };
      greetd.enableGnomeKeyring = true;
      greetd-password.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
    tpm2.enable = true;
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
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        nvidia-vaapi-driver
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
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        flake-registry = "";
        keep-going = true;
        keep-outputs = true;
        keep-derivations = true;
        warn-dirty = false;
        nix-path = config.nix.nixPath;
        trusted-users = [ "micgao" ];
        use-xdg-base-directories = true;
      };
      channel.enable = false;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
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
    libvirtd = {
      enable = true;
    };
    virtualbox.host = {
      enable = true;
    };
    # vmware.host = {
    #   enable = true;
    #   extraConfig = ''
    #     mks.gl.allowUnsupportedDrivers = "TRUE"
    #     mks.vk.allowUnsupportedDevices = "TRUE"
    #   '';
    # };
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
    upower.enable = true;
    tuned = {
      enable = true;
      ppdSupport = true;
      settings = {
        daemon = true;
        dynamic_tuning = true;
      };
      ppdSettings = {
        main = {
          default = "performance";
        };
      };
    };
    resolved = {
      enable = true;
      dnsovertls = "true";
    };
    passSecretService.enable = true;
    flatpak.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = ["--performance"];
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
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "start-hyprland";
          user = "micgao";
        };
        initial_session = {
          command = "start-hyprland";
          user = "micgao";
        };
      };
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
    throttled.enable = true;
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
        "libvirtd"
        "podman"
        "kvm"
        "rtkit"
      ];
    };
  };

  programs = {
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    virt-manager.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    steam = {
      enable = true;
    };
    nix-ld.dev.enable = true;
    gamescope = {
      enable = true;
    };
    hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    zsh.enable = true;
    gnupg = {
      dirmngr.enable = true;
      agent = {
        enable = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  gtk.iconCache.enable = true;

  system = {
    stateVersion = "23.11";
  };
}
