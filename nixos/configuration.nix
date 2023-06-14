{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.hyprland.nixosModules.default
      inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme
      inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
      inputs.nix-ld.nixosModules.nix-ld
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
    kernelParams = [
      "intel_iommu=on"
      "quiet"
    ];
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
        configurationLimit = 10;
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      verbose = false;
      systemd = {
        dbus.enable = true;
      };
    };
  };

  console = {
    useXkbConfig = true;
    earlySetup = false;
  };

  systemd = {
    network = {
      wait-online.enable = false;
    };
    services = {
      systemd-udev-settle.enable = false;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      wget
      glxinfo
      libva
      libglvnd
      glmark2
      libva-utils
      vulkan-loader
      vulkan-validation-layers
      egl-wayland
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXOS_OZONE_WL = "1";
      LIBSEAT_BACKEND = "logind";
      QT_QPA_PLATFORM = "wayland";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBSEAT_BACKEND = "logind";
      QT_QPA_PLATFORM = "wayland";
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
      xdgOpenUsePortal = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      abrmd.enable = true;
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
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
    };
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    wirelessRegulatoryDatabase = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = lib.mkDefault true;
      builders-use-substitutes = true;
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

  fonts = {
    fonts = with pkgs; [
      material-symbols
      font-awesome
      roboto
      noto-fonts
      inter
      hubot-sans
      mona-sans
      source-sans-pro
      source-serif-pro
      (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono" "SourceCodePro" "NerdFontsSymbolsOnly"]; })
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
      localConf = ''
        <alias>
          <family>Iosevka Term SS04 Extended Symbols</family>
          <prefer>
              <family>Iosevka Term SS04 Extended</family>
              <family>Symbols Nerd Font</family>
          </prefer>
        </alias>
      '';
      hinting = {
        enable = true;
        style = "hintfull";
      };
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka Fixed SS04 Extended Symbols"
        ];
        sansSerif = [
          "Inter"
          "Source Sans Pro"
        ];
        serif = [
          "Inter"
          "Source Serif Pro"
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
    };
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    resolvconf = {
      enable = true;
    };
    hostName = "X1E3";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Toronto";

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
    resolved = {
      enable = true;
      fallbackDns = [
        "45.90.28.0#ca38bb.dns.nextdns.io"
        "2a07:a8c0::#ca38bb.dns.nextdns.io"
        "45.90.30.0#ca38bb.dns.nextdns.io"
        "2a07:a8c1::#ca38bb.dns.nextdns.io"
      ];
      extraConfig = ''
        DNSOverTLS=yes
      '';
    };
    dbus = {
      enable = true;
      implementation = "broker";
    };
    logind = {
      lidSwitch = "ignore";
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
      libinput.enable = true;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    resilio = {
      enable = true;
      deviceName = "X1E3";
      enableWebUI = true;
      httpListenAddr = "127.0.0.1";
      httpListenPort = 9000;
    };
    roon-bridge.enable = true;
    roon-server.enable = true;
    btrfs.autoScrub.enable = true;
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
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };
  };

  programs = {
    nix-ld = {
      enable = true;
    };
    steam = {
      enable = true;
      package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
      gamescopeSession = {
        enable = true;
      };
    };
    hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland = {
        enable = true;
        hidpi = false;
      };
    };
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.stateVersion = "22.11";
}

