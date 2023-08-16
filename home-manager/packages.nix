{ pkgs, inputs, outputs, ... }: {

  nixpkgs.overlays = [
  ];

  home = {
    packages = with pkgs; [
      # nix things
      nix-init
      # impurities
      rustup
      nodejs
      python3Minimal
      distrobox
      # CLI things
      viddy
      httpie
      curlie
      clipboard-jh
      circumflex
      fd
      gopass
      gopass-hibp
      gopass-jsonapi
      gopass-summon-provider
      git-credential-gopass
      git-credential-keepassxc
      xplr
      rclone
      playerctl
      procs
      socat
      megacmd
      mpc-cli
      qobuz-dl
      protonmail-bridge
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
      wineWowPackages.wayland
    ];
  };
}
