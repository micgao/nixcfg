{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./bat.nix
    ./browsers.nix
    ./direnv.nix
    ./emacs.nix
    ./emulators.nix
    ./fonts.nix
    ./gaming.nix
    ./gpg.nix
    ./gitui.nix
    ./neovim.nix
    ./passwordstore.nix
    ./vscodium.nix
    ./zsh.nix
    ./alacritty
    ./bottom
    ./helix
    ./hyprland
    ./mako
    ./media
    ./waybar
    ./wezterm
    ./wofi
    ./zathura
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
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
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
    sessionPath = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
    packages = with pkgs; [
      rustup
      nodejs
      python3Minimal
      nushell
      clipboard-jh
      xplr
      rclone
      keepassxc
      pavucontrol
      playerctl
      networkmanagerapplet
      megacmd
      obsidian
      cryptomator
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      fd
      imagemagick
      zstd
      sqlite
      insomnia
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
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
    font = {
      name = "Inter";
      package = pkgs.inter;
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
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
