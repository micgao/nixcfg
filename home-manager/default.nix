{ inputs, config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./bottom
    ./helix
    ./hyprland
    ./kitty
    ./media
    ./nix-colors
    ./qt
    ./starship
    ./wezterm
    ./accounts.nix
    ./bat.nix
    ./browsers.nix
    ./cava.nix
    ./dunst.nix
    ./direnv.nix
    ./distrobox.nix
    ./emacs.nix
    ./fuzzel.nix
    ./fonts.nix
    ./gaming.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./gpg.nix
    ./gtk.nix
    ./jq.nix
    # ./ledger.nix
    ./mail.nix
    # ./neomutt.nix
    ./neovim.nix
    ./nix-index.nix
    ./nix-your-shell.nix
    ./packages.nix
    ./password.nix
    ./pueue.nix
    ./reaper.nix
    ./ripgrep.nix
    ./vscodium.nix
    ./waybar.nix
    ./xdg.nix
    ./yazi.nix
    ./zathura.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  home = {
    username = "micgao";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
    pointerCursor = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
      size = 24;
      gtk.enable = true;
      hyprcursor.enable = true;
    };
    preferXdgDirectories = true;
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GTK_THEME = "sequoia";
      GTK_THEME_VARIANT = "dark";
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      _JAVA_AWT_WM_NONREPARENTING = 1;
      GDK_BACKEND = "wayland,x11,*";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = 1;
      __GL_GSYNC_ALLOWED = 1;
      CUDA_DISABLE_PERF_BOOST = 1;
    };
  };

  news.display = "show";

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
