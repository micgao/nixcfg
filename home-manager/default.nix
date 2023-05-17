{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./steam.nix
    ./bat.nix
    ./browsers.nix
    ./emacs.nix
    ./emulators.nix
    ./fonts.nix
    ./gitui.nix
    ./mako.nix
    ./neovim.nix
    ./zathura.nix
    ./zsh.nix
    ./alacritty
    ./helix
    ./hyprland
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
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 16;
    };
    sessionPath = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
      "$HOME/.local/bin"
    ];
    packages = with pkgs; [
      inputs.nixpkgs-wayland.packages.${system}.imv
      inputs.nixpkgs-wayland.packages.${system}.kanshi
      inputs.nixpkgs-wayland.packages.${system}.wlay
      inputs.nixpkgs-wayland.packages.${system}.wl-clipboard
      inputs.nixpkgs-wayland.packages.${system}.wtype
      rustup
      nushell
      clipboard-jh
      rclone
      dconf
      keepassxc
      pavucontrol
      obsidian
      cryptomator
      (ripgrep.override {withPCRE2 = true;})
      fd
      imagemagick
      zstd
      sqlite
      distrobox
      libvirt
      virt-manager
      qemu_full
      feather-wallet
      picocrypt
    ];
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 16;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/IconThemeName" = "Dracula";
      "Net/ThemeName" = "Dracula";
    };
  };
    
  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

}
