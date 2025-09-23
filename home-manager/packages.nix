{ pkgs, inputs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # nixpkgs.overlays = [
  #   inputs.nixpkgs-wayland.overlay
  # ];

  home = {
    packages = with pkgs; [
      qmk
      via
      viddy
      streamlink
      code-cursor
      opencode
      inputs.firefox-nightly.packages.${pkgs.system}.firefox-devedition-bin
      brave
      gcr
      inputs.ghostty.packages."${pkgs.system}".default
      gfn-electron
      rustup
      distrobox
      comma
      spacedrive
      hoppscotch
      curlie
      circumflex
      ffmpeg
      fd
      xdg-utils
      skate
      gpg-tui
      playerctl
      mpc-cli
      vlc
      procs
      megacmd
      protonmail-bridge
      keepassxc
      pavucontrol
      obsidian
      jetbrains-toolbox
      feather
      (wine.override { wineBuild = "wineWow"; wineRelease = "staging"; fontconfigSupport = true; alsaSupport = true; gtkSupport = true; openglSupport = true; dbusSupport = true; openclSupport = true; cursesSupport = true; vaSupport = true; pulseaudioSupport = true; udevSupport = true; vulkanSupport = true; sdlSupport = true; usbSupport = true; waylandSupport = true; embedInstallers = true; })
      qobuz-dl
      streamrip
      monero-gui
      monero-cli
    ];
  };
}
