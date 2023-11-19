{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
      nixfmt
      nix-init
      nix-ld-rs
      nix-update
      rustup
      nodejs
      python3Minimal
      distrobox
      bottles
      ollama
      viddy
      bruno
      curlie
      clipboard-jh
      circumflex
      fd
      gopass
      gpg-tui
      git-credential-gopass
      git-credential-keepassxc
      rclone
      playerctl
      procs
      megacmd
      mpc-cli
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
      monero-cli
    ];
  };
}
