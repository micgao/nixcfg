{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
      # things supposedly required for doomemacs
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      fd
      imagemagick
      zstd
      sqlite
      editorconfig-core-c
      # nix things
      nix-init
      nix-ld-rs
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
      procps
      socat
      megacmd
      qobuz-dl
      git-credential-keepassxc
      gopass
      gopass-hibp
      gopass-jsonapi
      gopass-summon-provider
      git-credential-gopass
      # crypto things
      feather-wallet
      monero-gui
      # desktop things
      keepassxc
      pavucontrol
      obsidian
      jetbrains-toolbox
      insomnia
      virt-manager
      protonmail-bridge
      # other things
      wineWowPackages.wayland
    ];
  };
}
