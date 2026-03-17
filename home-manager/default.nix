{ inputs, config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./bottom
    ./helix
    ./hyprland
    ./kitty
    ./media
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
    ./editors.nix
    ./emacs.nix
    ./fuzzel.nix
    ./fonts.nix
    ./fzf.nix
    ./gaming.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./gpg.nix
    ./gtk.nix
    ./jq.nix
    ./mail.nix
    ./neovim.nix
    ./nix-index.nix
    ./nix-your-shell.nix
    ./packages.nix
    ./password.nix
    ./pueue.nix
    ./reaper.nix
    ./ripgrep.nix
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
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
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
