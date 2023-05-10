{ inputs, lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.hyprland.nixosModules.default
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-laptop-ssd
      inputs.hardware.nixosModules.lenovo-thinkpad-x1-extreme
      inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";

  services.flatpak.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  nix = {
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
	"https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
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
  };

  networking.networkmanager.enable = true;

  services.fstrim.enable = true;

  networking.hostName = "x1e3";

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Toronto";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
  };

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };

  programs.dconf.enable = true;

  sound.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [
    zsh
    nushell
  ];

  programs.zsh.enable = true;

  users.users.micgao = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gamemode"
      "vboxusers"
      "libvirtd"
    ];
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

  system.stateVersion = "22.11";

}

