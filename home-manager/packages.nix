{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.nix-ld-rs.overlays.default
    inputs.nixpkgs-wayland.overlay
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0"
        pkgs.lib.optional (pkgs.megacmd.version == "1.6.3") "freeimage-unstable-2021-11-01"
      ];
    };
  };

  home = {
    packages = with pkgs; [
      warp-terminal
      nix-ld-rs
      firefox-devedition
      rustup
      distrobox
      comma
      vagrant
      # bottles
      devbox
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
      megacmd
      protonmail-bridge
      gimp-with-plugins
      keepassxc
      pavucontrol
      obsidian
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
