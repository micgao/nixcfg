{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    ./nix-ld.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
  ];

  boot = {
    bootspec.enableValidation = true;
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" "splash" "nvidia_drm.modeset=1" ];
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
      verbose = false;
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };
    modprobeConfig.enable = true;
  };

  systemd = {
    network = {
      enable = true;
      wait-online = {
        enable = false;
        anyInterface = true;
        extraArgs = ["--ipv4"];
      };
    };
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
    etc = lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;
    systemPackages = with pkgs; [];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      LIBSEAT_BACKEND = "logind";
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    };
    homeBinInPath = true;
    localBinInPath = true;
    enableAllTerminfo = true;
    shells = with pkgs; [ zsh nushell ];
    binsh = "${pkgs.dash}/bin/dash";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };

  security = {
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      abrmd.enable = true;
      tctiEnvironment.enable = true;
    };
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      loginLimits = [
        {
          domain = "@audio";
          type = "-";
          item = "rtprio";
          value = "95";
        }
        {
          domain = "@audio";
          type = "-";
          item = "memlock";
          value = "unlimited";
        }
      ];
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.nixpkgs-wayland.overlay
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
    pulseaudio.enable = false;
    cpu = {
      intel = {
        updateMicrocode = true;
        sgx.provision.enable = true;
      };
      x86.msr.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vulkan-validation-layers
        libva
        intel-compute-runtime
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
        intel-ocl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
      ];
    };
    nvidia = {
      prime = {
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
        sync.enable = true;
      };
      open = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };
    trackpoint.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-going = true;
      keep-outputs = true;
      warn-dirty = false;
      log-lines = 20;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = [ "/etc/nix/path" ];
  };

  fonts = {
    packages = with pkgs; [
      material-symbols
      noto-fonts
      noto-fonts-monochrome-emoji
      roboto
      roboto-mono
      inter
      pretendard
      cascadia-code
      source-code-pro
      source-sans-pro
      intel-one-mono
      recursive
      iosevka-ss04
      (nerdfonts.override {
        fonts =
          [ "FiraCode" "JetBrainsMono" "SourceCodePro" "NerdFontsSymbolsOnly" ];
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
      localConf = ''
        <alias>
          <family>Iosevka Fixed SS04 Extended Symbols</family>
          <prefer>
              <family>Iosevka Fixed SS04 Extended</family>
              <family>Symbols Nerd Font</family>
          </prefer>
        </alias>
      '';
      hinting = {
        enable = true;
        style = "slight";
      };
      defaultFonts = {
        monospace = [ "Iosevka SS04" "Noto Emoji" ];
        sansSerif = [ "Inter Variable" "Noto Emoji" ];
        serif = [ "Noto Serif" "Noto Emoji" ];
        emoji = [ "Noto Emoji" ];
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      enableNvidia = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    kvmgt = {
      enable = true;
      device = "0000:00:02.0";
      vgpus = {
        "i915-GVTg_V5_4" = {
          uuid = ["f8bcf958-667e-11ee-9014-972c93a54fcc"];
        };
      };
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        runAsRoot = false;
      };
    };
    virtualbox.host = { enable = true; };
    vmware.host = {
      enable = true;
    };
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    hostName = "X1E3";
  };

  i18n = {
    supportedLocales =
      [ "en_US.UTF-8/UTF-8" "en_CA.UTF-8/UTF-8" "fr_CA.UTF-8/UTF-8" ];
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Toronto";

  services = {
    hardware.bolt.enable = true;
    fwupd = {
      enable = true;
    };
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
      implementation = "broker";
      packages = with pkgs; [ gcr dconf ];
    };
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };
    xserver.videoDrivers = ["nvidia"];
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
    btrfs.autoScrub.enable = true;
    throttled = {
      enable = true;
    };
    gnome.gnome-keyring.enable = true;
  };

  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  sound.enable = false;

  users = {
    defaultUserShell = pkgs.zsh;
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
        "gamemode"
        "vboxusers"
        "libvirtd"
        "networkmanager"
        "podman"
        "kvm"
        "rtkit"
      ];
    };
    extraGroups.vboxusers.members = [ "micgao" ];
  };

  programs = {
    command-not-found.enable = false;
    nix-index-database.comma.enable = true;
    less.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          dconf
        ];
      };
      remotePlay.openFirewall = true;
      gamescopeSession = {
        enable = true;
        args = [
          "--steam"
          "--rt"
          "--hdr-enabled"
          "--fullscreen"
          "-W 1929"
          "-H 1080"
        ];
      };
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    hyprland = {
      enable = true;
    };
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  system = {
    stateVersion = "23.11";
  };
}

