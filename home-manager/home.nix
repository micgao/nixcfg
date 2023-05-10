{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./steam.nix
    ./bat.nix
    ./emacs.nix
    ./gitui.nix
    ./mako.nix
    ./zsh.nix
    ./alacritty
    ./hyprland
    ./wezterm
    ./wofi
  ];

  nixpkgs = {
    overlays = [
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
    sessionPath = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      keepassxc
      pavucontrol
      obsidian
      cryptomator
      binutils
      (ripgrep.override {withPCRE2 = true;})
      gnutls
      fd
      imagemagick
      zstd
      sqlite
      distrobox
      virtualbox
      libvirt
      virt-manager
      qemu_full
    ];
  };


  fonts.fontconfig.enable = true;

  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  systemd.user.startServices = "sd-switch";

}
