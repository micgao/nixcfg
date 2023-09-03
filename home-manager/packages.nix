{ pkgs, inputs, outputs, ... }: {

  home = {
    packages = with pkgs; [
      nixfmt
      nix-init
      rustup
      nodejs
      python3Minimal
      distrobox
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
      nb
      protonmail-bridge
      gimp-with-plugins
      keepassxc
      pavucontrol
      helvum
      obsidian
      insomnia
      jetbrains-toolbox
      virt-manager
      wineWowPackages.wayland
      bottles
      qobuz-dl
      feather-wallet
      monero-gui
    ];
  };
}
