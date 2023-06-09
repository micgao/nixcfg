{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./bottom
    ./foot
    ./fuzzel
    ./helix
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./qt
    ./starship
    ./swaylock
    ./waybar
    ./wezterm
    ./wlogout
    ./accounts.nix
    ./bat.nix
    ./browsers.nix
    ./direnv.nix
    ./emacs.nix
    ./feh.nix
    ./fonts.nix
    ./gaming.nix
    ./git.nix
    ./go.nix
    ./gpg.nix
    ./gtk.nix
    ./jq.nix
    ./neomutt.nix
    ./neovim.nix
    ./newsboat.nix
    ./nix-database-index.nix
    ./nnn.nix
    ./packages.nix
    ./password.nix
    ./playerctld.nix
    ./pywal.nix
    ./reaper.nix
    ./rtx.nix
    ./tealdeer.nix
    ./vscodium.nix
    ./xdg.nix
    ./xsettingsd.nix
    ./zathura.nix
    ./zoxide.nix
    ./zsh.nix
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
      XCURSOR_SIZE = "24";
    };
    sessionPath = [
      "${config.home.homeDirectory}/.cargo/bin"
    ];
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

}
