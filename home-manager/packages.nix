{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
      nixfmt
      nix-init
      nix-melt
      nix-ld-rs
      nix-update
      rustup
      nodejs
      python3Minimal
      distrobox
      viddy
      bruno
      curlie
      clipboard-jh
      circumflex
      fd
      gopass
      gopass-hibp
      gopass-jsonapi
      gopass-summon-provider
      gpg-tui
      git-credential-gopass
      git-credential-keepassxc
      xplr
      rclone
      playerctl
      procs
      socat
      megacmd
      mpc-cli
      nb
      protonmail-bridge
      gimp-with-plugins
      keepassxc
      pavucontrol
      obsidian
      jetbrains-toolbox
      virt-manager
      virt-viewer
      thunderbird
      wineWowPackages.wayland
      qobuz-dl
      feather-wallet
      monero-gui
    ];
  };
}
