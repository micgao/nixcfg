{ pkgs, inputs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        pkgs.lib.optional (pkgs.megacmd.version == "1.6.3") "freeimage-unstable-2021-11-01"
      ];
    };
  };

  # nixpkgs.overlays = [
  #   inputs.nixpkgs-wayland.overlay
  # ];

  home = {
    packages = with pkgs; [
      inputs.bloop-ai.packages.${pkgs.system}.default
      inputs.bloop-ai.packages.${pkgs.system}.frontend
      firefox-devedition
      mullvad-browser
      warp-terminal
      rustup
      distrobox
      comma
      vagrant
      bottles
      spacedrive
      ollama
      hoppscotch
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
