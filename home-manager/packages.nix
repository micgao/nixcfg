{ pkgs, ... }: {

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
      firefox-devedition
      mullvad-browser
      # zed-editor
      # (warp-terminal.override { waylandSupport = true; })
      ffmpeg_7-full
      rustup
      distrobox
      comma
      vagrant
      bottles
      spacedrive
      hoppscotch
      curlie
      hurl
      circumflex
      fd
      skate
      gpg-tui
      playerctl
      mpc-cli
      procs
      megacmd
      protonmail-bridge
      # gimp
      keepassxc
      pavucontrol
      obsidian
      roon-tui
      jetbrains-toolbox
      virt-viewer
      thunderbird
      feather
      (wine.override { wineBuild = "wineWow"; wineRelease = "staging"; fontconfigSupport = true; alsaSupport = true; gtkSupport = true; openglSupport = true; dbusSupport = true; openclSupport = true; cursesSupport = true; vaSupport = true; pulseaudioSupport = true; udevSupport = true; vulkanSupport = true; sdlSupport = true; usbSupport = true; waylandSupport = true; embedInstallers = true; })
      qobuz-dl
      monero-gui
      monero-cli
    ];
  };
}
