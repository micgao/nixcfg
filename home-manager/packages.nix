{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
    inputs.nixpkgs-wayland.overlay
  ];

  home = {
    packages = with pkgs; [
      nix-ld-rs
      firefox-devedition
      rustup
      distrobox
      vagrant
      bottles
      spacedrive
      ollama
      bruno
      curlie
      hurl
      clipboard-jh
      circumflex
      fd
      polkit
      gopass
      gpg-tui
      git-credential-gopass
      git-credential-keepassxc
      rclone
      playerctl
      procs
      zip
      unzip
      p7zip
      megacmd
      mpc-cli
      protonmail-bridge
      gimp-with-plugins
      keepassxc
      pavucontrol
      obsidian
      inkdrop
      jetbrains-toolbox
      virt-viewer
      thunderbird
      (wine.override { wineBuild = "wineWow"; wineRelease = "staging"; fontconfigSupport = true; alsaSupport = true; gtkSupport = true; openglSupport = true; dbusSupport = true; openclSupport = true; cursesSupport = true; vaSupport = true; pulseaudioSupport = true; udevSupport = true; vulkanSupport = true; sdlSupport = true; usbSupport = true; waylandSupport = true; embedInstallers = true; })
      qobuz-dl
      feather-wallet
      monero-gui
      monero-cli
    ];
  };
}
