{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
  ];

  boot = {
    bootspec.enableValidation = true;
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" ];
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
      verbose = false;
      systemd = {
        enable = true;
      };
    };
    modprobeConfig.enable = true;
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
      btrfs-progs
      appimage-run
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      libglvnd
      vkbasalt
      vkbasalt-cli
    ];
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
    users = { micgao = import ../home-manager; };
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    cpu.intel.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        sync.enable = true;
      };
      open = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };
    trackpoint.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      builders-use-substitutes = true;
      keep-derivations = true;
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
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };

  fonts = {
    packages = with pkgs; [
      material-symbols
      font-awesome
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
      includeUserConf = true;
      subpixel = { rgba = "rgb"; };
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
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Iosevka Fixed SS04 Extended Symbols" "Roboto Mono" ];
        sansSerif = [ "Roboto" "Inter" ];
        serif = [ "Noto Serif" ];
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
    virtualbox.host = { enable = true; };
    # vmware.host = {
    #   enable = true;
    # };
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
    fwupd.enable = true;
    openssh = {
      enable = true;
      settings = { PermitRootLogin = "no"; };
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
      packages = [ pkgs.gcr ];
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
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
        "networkmanager"
        "podman"
      ];
    };
    extraGroups.vboxusers.members = [ "micgao" ];
  };

  programs = {
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
    };
    hyprland = {
      enable = true;
      enableNvidiaPatches = true;
    };
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system = {
    stateVersion = "23.11";
  };
}

