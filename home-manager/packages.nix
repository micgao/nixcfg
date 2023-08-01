{ pkgs, inputs, outputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
      # nix things
      nix-init
      nix-ld-rs
      # things that make me impure
      rustup
      nodejs
      python3Full
      distrobox
      # CLI things
      httpie
      clipboard-jh
      circumflex
      xplr
      rclone
      playerctl
      procps
      procs
      socat
      megacmd
      mpc-cli
      qobuz-dl
      git-credential-keepassxc
      gopass
      gopass-hibp
      gopass-jsonapi
      gopass-summon-provider
      git-credential-gopass
      protonmail-bridge
      # crypto things
      feather-wallet
      monero-gui
      # desktop things
      gimp-with-plugins
      nyxt
      keepassxc
      pavucontrol
      helvum
      obsidian
      insomnia
      jetbrains-toolbox
      virt-manager
      # other things
      wineWowPackages.wayland
    ];
  };
}
