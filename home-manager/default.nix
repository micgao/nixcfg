{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./bat.nix
    ./browsers.nix
    ./emacs.nix
    ./emulators.nix
    ./fonts.nix
    ./gaming.nix
    ./gitui.nix
    ./neovim.nix
    ./passwordstore.nix
    ./vscodium.nix
    ./zathura.nix
    ./zsh.nix
    ./alacritty
    ./bottom
    ./helix
    ./hyprland
    ./mako
    ./music
    ./waybar
    ./wezterm
    ./wofi
  ];

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

  home = {
    username = lib.mkDefault "micgao";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";
    pointerCursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 16;
      x11.enable = true;
      gtk.enable = true;
    };
    sessionPath = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
    packages = with pkgs; [
      imv
      kanshi
      wlay
      wl-clipboard
      wtype
      rustup
      nodejs
      nushell
      clipboard-jh
      rclone
      keepassxc
      pavucontrol
      playerctl
      networkmanagerapplet
      obsidian
      cryptomator
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      fd
      imagemagick
      zstd
      sqlite
      distrobox
      virt-manager
      wineWowPackages.wayland
      feather-wallet
      picocrypt
    ];
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 16;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    font = {
      package = pkgs.inter;
      name = "Inter";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "breeze";
      package = pkgs.breeze-qt5;
    };
  };

  services = {
    xsettingsd = {
      enable = true;
      settings = {
        "Xft/Hinting" = 1;
        "Xft/HintStyle" = "hintslight";
        "Xft/Antiaslias" = 1;
        "Xft/RGBA" = "rgb";
        "Net/IconThemeName" = "Dracula";
        "Net/ThemeName" = "Dracula";
      };
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.feh.enable = true;

  programs.htop.enable = true;

  programs.jq.enable = true;

  programs.tealdeer.enable = true;

  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;

  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

}
