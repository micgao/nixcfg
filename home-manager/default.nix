{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./bat.nix
    ./browsers.nix
    ./direnv.nix
    ./emacs.nix
    # ./emulators.nix
    ./fonts.nix
    ./gaming.nix
    ./gpg.nix
    ./git.nix
    ./gtk.nix
    ./go.nix
    ./neovim.nix
    ./nix-database-index.nix
    ./nnn.nix
    ./reaper.nix
    ./rtx.nix
    ./packages.nix
    ./passwordstore.nix
    ./rtx.nix
    # ./pfetch.nix
    ./vscodium.nix
    ./zsh.nix
    ./alacritty
    ./bottom
    ./fuzzel
    ./helix
    ./hyprland
    ./mako
    ./media
    ./starship
    ./swaylock
    ./waybar
    ./wezterm
    # ./wofi
    ./wlogout
    ./qt
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
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
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
    configHome = "${config.home.homeDirectory}/.config";
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.feh.enable = true;

  programs.jq.enable = true;

  programs.tealdeer.enable = true;

  programs.pywal.enable = true;

  programs.newsboat.enable = true;

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

}
