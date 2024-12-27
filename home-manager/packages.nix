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
      qt6.qtwayland
      libnotify
      qmk
      streamlink
      code-cursor
      firefox-devedition
      brave
      mullvad-browser
      gcr
      # gitbutler
      inputs.zen.packages."${system}".default
      inputs.ghostty.packages."${system}".default
      stirling-pdf
      zed-editor
      rustup
      distrobox
      comma
      # bottles
      spacedrive
      hoppscotch
      curlie
      circumflex
      ffmpeg
      fd
      trashy
      xdg-utils
      skate
      gpg-tui
      playerctl
      mpc-cli
      vlc
      procs
      megacmd
      protonmail-bridge
      # gimp
      keepassxc
      pwvucontrol
      obsidian
      jetbrains-toolbox
      thunderbird
      feather
      (wine.override { wineBuild = "wineWow"; wineRelease = "staging"; fontconfigSupport = true; alsaSupport = true; gtkSupport = true; openglSupport = true; dbusSupport = true; openclSupport = true; cursesSupport = true; vaSupport = true; pulseaudioSupport = true; udevSupport = true; vulkanSupport = true; sdlSupport = true; usbSupport = true; waylandSupport = true; embedInstallers = true; })
      qobuz-dl
      streamrip
      # monero-gui
      # monero-cli
    ];
  };
}
