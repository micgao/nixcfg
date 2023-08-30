{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.hyprland.nixosModules.default
  ];

  boot = {
    bootspec = {
      enableValidation = true;
    };
    tmp = {
      cleanOnBoot = true;
    };
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_zen;
    blacklistedKernelModules = [
      "nouveau"
    ];
    kernelParams = [
      "quiet"
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
      systemd.enable = true;
      verbose = false;
    };
    modprobeConfig.enable = true;
    extraModprobeConfig = ''
      options nvidia-drm modeset=1
    '';
  };

  console = {
    colors = [
      "131317"
      "f58ee0"
      "8eb5f5"
      "9898a6"
      "c58fff"
      "fdfdfe"
      "ffbb88"
      "868690"
      "575861"
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

  systemd = {
    services = {
      systemd-udev-settle.enable = false;
      NetworkManager-wait-online.enable = false;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      btrfs-progs
      appimage-run
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      egl-wayland
      libglvnd
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      LIBSEAT_BACKEND = "logind";
      TZ = "/etc/localtime";
      POLKIT_AUTH_AGENT = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    };
    homeBinInPath = true;
    localBinInPath = true;
    enableAllTerminfo = true;
    shells = with pkgs; [
      zsh
      nushell
    ];
    binsh = "${pkgs.dash}/bin/dash";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.nixpkgs-wayland.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      micgao = import ../home-manager;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    cpu.intel.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };
    trackpoint.enable = true;
  };

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      builders-use-substitutes = true;
      keep-derivations = true;
      keep-going = true;
      keep-outputs = true;
      warn-dirty = false;
      sandbox = true;
      max-jobs = "auto";
      log-lines = 20;
      flake-registry = "/etc/nix/registry.json";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };

  fonts = {
    packages = with pkgs; [
      emacs-all-the-icons-fonts
      material-symbols
      font-awesome
      montserrat
      noto-fonts
      noto-fonts-emoji
      roboto
      roboto-mono
      inter
      source-code-pro
      source-sans-pro
      source-serif-pro
      intel-one-mono
      recursive
      iosevka-ss04
      # (iosevka.override {
      #   set = "fixed-ss04";
      # })
      (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono" "SourceCodePro" "NerdFontsSymbolsOnly"]; })
    ];
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      enable = true;
      antialias = true;
      includeUserConf = true;
      subpixel = {
        rgba = "rgb";
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
        style = "medium";
      };
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka Fixed SS04 Extended Symbols"
          "Source Code Pro"
        ];
        sansSerif = [
          "Noto Sans"
        ];
        serif = [
          "Noto Serif"
        ];
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      enableNvidia = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    virtualbox.host = {
       enable = true;
    };
    vmware.host = {
      enable = true;
      extraConfig = ''
        mks.gl.allowUnsupportedDrivers = "TRUE"
        mks.vk.allowUnsupportedDevices = "TRUE"
      '';
    };
    waydroid = {
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
    supportedLocales = [ "en_US.UTF-8/UTF-8" "en_CA.UTF-8/UTF-8" "fr_CA.UTF-8/UTF-8" ];
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_CA.UTF-8";
    };
  };

  time.timeZone = "America/Toronto";

  services = {
    fwupd.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
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
    };
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };
    xserver = {
      videoDrivers = [ "nvidia" ];
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
    roon-bridge = {
      enable = true;
      openFirewall = true;
    };
    roon-server = {
      enable = true;
      openFirewall = true;
    };
    btrfs.autoScrub.enable = true;
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
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "input"
        "gamemode"
        "vboxusers"
        "libvirtd"
	      "qemu-libvirtd"
        "networkmanager"
        "podman"
      ];
    };
    extraGroups.vboxusers.members = ["micgao"];
  };

  programs = {
    dconf.enable = true;
    xwayland.enable = true;
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
          libgdiplus
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
      gamescopeSession.enable = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
    };
    gamescope = {
      enable = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      enableNvidiaPatches = true;
      xwayland.enable = true;
    };
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system = {
    autoUpgrade.enable = false;
    stateVersion = "23.11";
  };
}

