{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.hyprland.nixosModules.default
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-laptop-ssd
      inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme
      inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    ];

  boot = {
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_lqx;
    kernelParams = [
      "intel_iommu=on"
      "quiet"
    ];

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 10;
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      verbose = false;
      systemd.dbus.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      wget
      acpi
      libva
      libva-utils
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
    homeBinInPath = true;
    localBinInPath = true;
    enableAllTerminfo = true;
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shells = with pkgs; [
      zsh
      nushell
    ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      j];
      xdgOpenUsePortal = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "gtk2";
  };

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
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
    logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
    };
    flatpak.enable = true;
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
    cpu.intel.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
    };
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
      trusted-users = [ "root" "@wheel" ];
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
      roboto
      noto-fonts
      inter
      hubot-sans
      mona-sans
      source-sans-pro
      (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono" "SourceCodePro"]; })
    ];
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      enable = true;
      includeUserConf = true;
      antialias = true;
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };
      hinting = {
        enable = true;
      };
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka SS04 Extended"
          "SauceCodePro Nerd Font Mono"
          "JetBrainsMonoNL Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Inter"
          "Hubot-Sans"
          "Source Sans Pro"
          "Noto Color Emoji"
        ];
        serif = [
          "Inter"
          "Noto Serif"
          "Noto Color Emoji"
        ];
      };
    };
    enableDefaultFonts = false;
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
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.package = pkgs.qemu_kvm;
    };
    virtualbox.host = {
      enable = true;
    };
  };

  networking = {
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
    };
    hostName = "x1e3";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Toronto";

  services = {
    gnome.gnome-keyring.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      libinput.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    acpid.enable = true;
    btrfs.autoScrub.enable = true;
    thermald.enable = true;
    upower.enable = true;
    tlp.enable = true;
  };

  sound.enable = true;

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
        "networkmanager"
        "podman"
        "git"
      ];
    };
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        glib
        glibc
        icu
        libunwind
        libuuid
        libsecret
        openssl
        stdenv.cc.cc
        util-linux
        zlib
      ];
    };
    java ={
      enable = true;
      package = pkgs.jre;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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
      pinentryFlavor = "gnome3";
    };
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
    };
  };

  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "22.11";

}

