{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ./ephemeral-root.nix
      ./cachix.nix
      ./nvidia.nix
      ./ollama.nix
      inputs.disko.nixosModules.disko
      inputs.nix-index-database.nixosModules.default
      inputs.hyprland.nixosModules.default
      inputs.helium.nixosModules.default
    ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd.enable = true;
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];
    };
    channel.enable = false;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  networking = {
    hostName = "X1E3";
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
      wifi.backend = "iwd";
    };
    extraHosts = ''
      0.0.0.0 dota2.com
      0.0.0.0 www.dota2.com
      :: dota2.com
    '';
  };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  users = {
    users = {
      root = {
        initialHashedPassword = "$y$j9T$9V8u/usg9Qn1.faCoUdpg1$DTJhtuuMX9kV7aKdaa9SpY3RfC8J2IGPsSn.OalVztC";
      };
      micgao = {
        isNormalUser = true;
	initialHashedPassword = "$y$j9T$gfbd7XBkE5n/5KiLtVwmQ/$tjeFFgYRBpwtpoeFqw6mqD1jxHZmHcOj1OxZqpgYuDC";
	shell = pkgs.zsh;
	extraGroups = [
	  "wheel"
	  "video"
	  "audio"
	  "i2c"
	  "networkmanager"
	  "rtkit"
	  "plugdev"
	  "input"
	  "kvm"
	];
	packages = with pkgs; [
	  inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default
	  inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
	  kitty
	  hyprpwcenter
	  obsidian
	  rose-pine-hyprcursor
	  rose-pine-cursor
	  tofi
	  mangohud
	  keepassxc
	  ripgrep
	  fzf
	];
      };
    };
  };

  hardware = {
    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    };
    enableRedistributableFirmware = true;
  };

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb = {
        model = "pc105";
	layout = "us,ca";
      };
    };
    userborn = {
      enable = true;
      static = false;
    };
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
    oo7.enable = true;
    dunst = {
      enable = true;
      enableWayland = true;
      enableX11 = false;
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
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    fstrim.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
    };
    tuned = {
      enable = true;
      ppdSupport = true;
      settings = {
        daemon = true;
        dynamic_tuning = true;
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
    throttled.enable = true;
    scx-loader = {
      enable = true;
      config = {
        default_mode = "Auto";
      };
    };
  };

  programs = {
    zsh.enable = true;
    nushell.enable = true;
    ssh.startAgent = true;
    zoxide.enable = true;
    foot.enable = true;
    nix-index-database = {
      enable = true;
      comma.enable = true;
    };
    helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=auto"
	"--enable-features=WaylandLinuxDrmSyncobj"
      ];
    };
    firefox =  {
      enable = true;
      package = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
    };
    neovim = {
      enable = true;
      package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultEditor = true;
      viAlias = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
	mangohud
      ];
    };
    gamescope = {
      enable = true;
      enableWsi = true;
    };
    dconf.enable = true;
  };

  security = {
    pam.services = {
      greetd.oo7.enable = true;
      login.oo7.enable = true;
    };
    rtkit.enable = true;
    polkit.enable = true;
    soteria.enable = true;
  };

  environment = {
    shells = with pkgs; [
      zsh
      nushell
    ];
    systemPackages = with pkgs; [
      git
    ];
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      configPackages = with pkgs; [
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
	  "org.freedesktop.impl.portal.Secret" = "oo7-portal";
        };
        hyprland = {
          default = ["hyprland" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
	  "org.freedesktop.impl.portal.Secret" = "oo7-portal";
        };
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      inter
      cascadia-code
      material-symbols
      (iosevka-bin.override { variant = "SS04"; })
      nerd-fonts.symbols-only
    ];
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      enable = true;
      allowBitmaps = false;
      includeUserConf = true;
      defaultFonts = {
        monospace = [ "Iosevka SS04" ];
        sansSerif = [ "Inter" ];
      };
    };
  };

  system = {
    stateVersion = "26.05";
    nixos-init.enable = true;
    etc.overlay = {
      enable = true;
      mutable = true;
    };
  };
}

