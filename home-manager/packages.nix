{ pkgs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0"
        pkgs.lib.optional (pkgs.megacmd.version == "1.6.3") "freeimage-unstable-2021-11-01"
      ];
    };
  };

  # nixpkgs.overlays = [
  #   inputs.nixpkgs-wayland.overlay
  # ];

  home = {
    packages = with pkgs; [
      firefox-devedition
      mullvad-browser
      rustup
      distrobox
      comma
      vagrant
      bottles
      devbox
      spacedrive
      ollama
      bruno
      curlie
      hurl
      circumflex
      fd
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
      appflowy
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
