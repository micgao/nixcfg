{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    ./nix-ld.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    inputs.envfs.nixosModules.envfs
    inputs.nix-ld.nixosModules.nix-ld
  ];

  boot = {
    bootspec = {
      enable = true;
      enableValidation = true;
    };
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "nvidia-drm.fbdev=1"
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
  };

  systemd.services.NetworkManager-wait-online.enable = false;
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
      git
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
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [ "hyprland" "gtk" ];
      };
    };
  };

  security = {
    pam.services = {
      hyprlock = { };
      greetd.enableGnomeKeyring = true;
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
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { micgao = import ../home-manager; };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
      package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa.drivers;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
        intel-ocl
      ];
      extraPackages32 = with pkgs; [
        nvidia-vaapi-driver
        libva
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
        intel-ocl
      ];
    };
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };
    nvidia = {
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        sync.enable = true;
      };
      open = true;
      modesetting.enable = true;
      gsp.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
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
      (google-fonts.override { fonts = [ "Inter" "Roboto Flex" ]; })
      cascadia-code
      source-code-pro
      source-sans-pro
      iosevka-ss04
      jost
      (nerdfonts.override {
        fonts =
          [ "NerdFontsSymbolsOnly" ];
      })
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
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Emoji" "Symbols Nerd Font" ];
      };
    };
  };

  virtualisation = {
    containers = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    kvmgt = {
      enable = true;
      device = "0000:00:02.0";
      vgpus = {
        "i915-GVTg_V5_4" = {
          uuid = [ "f8bcf958-667e-11ee-9014-972c93a54fcc" ];
        };
      };
    };
    libvirtd = {
      enable = true;
      nss.enable = true;
      onShutdown = "shutdown";
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
    wireguard.enable = true;
    wireless = {
      dbusControlled = true;
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

  location.provider = "geoclue2";

  services = {
    blueman.enable = true;
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
    timesyncd.enable = true;
    hardware.bolt.enable = true;
    fwupd.enable = true;
    resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        DNS=45.90.28.0#ca38bb.dns.nextdns.io
        DNS=2a07:a8c0::#ca38bb.dns.nextdns.io
        DNS=45.90.30.0#ca38bb.dns.nextdns.io
        DNS=2a07:a8c1::#ca38bb.dns.nextdns.io
        DNSOverTLS=yes
      '';
    };
    dbus = {
      enable = true;
      packages = with pkgs; [ gcr gnome-settings-daemon ];
      implementation = "broker";
    };
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    logind = {
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
    };
    fstrim.enable = true;
    greetd = {
      vt = 1;
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe config.programs.hyprland.package}";
          user = "micgao";
        };
      };
    };
    xserver.videoDrivers = [ "nvidia" ];
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
    roon-server = {
      enable = true;
      openFirewall = true;
    };
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [
        "/nix"
        "/etc"
        "/var/log"
        "/root"
        "/home"
      ];
    };
    thermald.enable = false;
    throttled.enable = true;
    geoclue2 = {
      enable = true;
      enableWifi = true;
    };
  };

  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  users = {
    users.micgao = {
      shell = pkgs.nushell;
      isNormalUser = true;
      packages = [
        inputs.home-manager.packages.${pkgs.system}.default
      ];
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
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [ pkgs.ffmpeg pkgs.imagemagick ];
      };
    };
    virt-manager.enable = true;
    less.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    steam.enable = true;
    gamescope.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
  };

  gtk.iconCache.enable = true;

  system = {
    stateVersion = "23.11";
  };
}
