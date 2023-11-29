{ outputs, lib, config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./anyrun
    ./bottom
    ./foot
    ./fuzzel
    ./helix
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./nix-colors
    ./qt
    ./starship
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
    ./nix-index-database.nix
    ./nix-your-shell.nix
    ./nnn.nix
    ./packages.nix
    ./password.nix
    ./playerctld.nix
    ./pueue.nix
    ./pywal.nix
    ./reaper.nix
    ./ripgrep.nix
    ./rtx.nix
    ./tealdeer.nix
    ./vscodium.nix
    ./xdg.nix
    ./yazi.nix
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
