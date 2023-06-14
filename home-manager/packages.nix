{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      # things supposedly required for doomemacs
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      fd
      imagemagick
      zstd
      sqlite
      # nix things
      nix-init
      # escape hatches to make life easier
      rustup
      nodejs
      python3Minimal
      distrobox
      # CLI things
      clipboard-jh
      circumflex
      xplr
      joshuto
      rclone
      playerctl
      megacmd
      qobuz-dl
      git-credential-keepassxc
      # crypto things
      feather-wallet
      monero-gui
      # desktop things
      keepassxc
      pavucontrol
      obsidian
      jetbrains-toolbox
      virt-manager
      # other things
      wineWowPackages.wayland
      timeshift
    ];
  };
}
