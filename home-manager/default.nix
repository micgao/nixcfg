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
    ./git.nix
    ./gtk.nix
    ./neovim.nix
    ./nix-database-index.nix
    ./passwordstore.nix
    ./pfetch.nix
    ./vscodium.nix
    ./qt.nix
    ./zsh.nix
    ./alacritty
    ./bottom
    ./fuzzel
    ./helix
    ./hyprland
    ./mako
    ./media
    ./swaylock
    ./waybar
    ./wezterm
    ./wofi
    ./wlogout
    ./zathura
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
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
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
    };
    sessionPath = [
      "$HOME/.cargo/bin/"
    ];
    packages = with pkgs; [
      nix-init
      rustup
      nodejs
      python3Minimal
      clipboard-jh
      xplr
      joshuto
      rclone
      keepassxc
      pavucontrol
      playerctl
      megacmd
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
      timeshift
      monero-gui
      jetbrains-toolbox
    ];
  };

  services = {
    xsettingsd = {
      enable = true;
      settings = {
        "Net/IconThemeName" = "${config.gtk.iconTheme.name}";
        "Net/ThemeName" = "${config.gtk.theme.name}";
      };
    };
    playerctld.enable = true;
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

  systemd.user.startServices = "sd-switch";

}
