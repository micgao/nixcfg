{ pkgs, lib, ... }: {

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
      insomnia
      jetbrains-toolbox
      virt-manager
      wineWowPackages.wayland
      qobuz-dl
      feather-wallet
      monero-gui
      (tree-sitter.withPlugins (p: builtins.attrValues p))
    ];
  };
}
