{ inputs, config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./bottom
    ./helix
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./nix-colors
    ./qt
    ./starship
    ./wezterm
    ./accounts.nix
    ./bat.nix
    ./browsers.nix
    ./cava.nix
    ./direnv.nix
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
    ./ledger.nix
    ./mail.nix
    ./neomutt.nix
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
    ./xsettingsd.nix
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
    };
    preferXdgDirectories = true;
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
