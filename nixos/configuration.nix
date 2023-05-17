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
    kernelPackages = pkgs.linuxKernel.packages.linux_lqx;
    kernelParams = [
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
  };

  environment = {
    enableAllTerminfo = true;
    shells = with pkgs; [
      zsh
      nushell
    ];
  };

  services = {
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
    };
    flatpak.enable = true;
    fstrim.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
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
    ];
    config = {
      allowUnfree = true;
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
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = lib.mkDefault true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      enableNvidia = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
    virtualbox.host = {
      enable = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "x1e3";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Toronto";

  services.xserver = {
    enable = true;
    updateDbusEnvironment = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };

  sound.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users.micgao = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "gamemode"
        "vboxusers"
        "libvirtd"
      ];
    };
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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

