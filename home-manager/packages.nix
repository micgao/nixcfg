{ pkgs, inputs, outputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
  ];

  home = {
    packages = with pkgs; [
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
      mpc-cli
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
      # wineWowPackages.wayland
    ];
  };
}
