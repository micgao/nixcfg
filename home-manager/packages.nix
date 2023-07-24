{ pkgs, inputs, outputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
      # things supposedly required for doomemacs
      xdg-utils
      (ripgrep.override {withPCRE2 = true;})
      graphviz
      fd
      imagemagick
      zstd
      sqlite
      editorconfig-core-c
      gnutls
      texlive.combined.scheme-medium
      # nix things
      nix-init
      nix-ld-rs
      inputs.devenv.packages.${pkgs.system}.devenv
      # things that make me impure
      rustup
      nodejs
      python3Full
      distrobox
      # CLI things
      clipboard-jh
      circumflex
      xplr
      rclone
      playerctl
      procps
      procs
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
      gimp-with-plugins
      keepassxc
      pavucontrol
      helvum
      obsidian
      insomnia
      jetbrains-toolbox
      virt-manager
      protonmail-bridge
      # other things
      wineWowPackages.wayland
    ];
  };
}
