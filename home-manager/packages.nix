{ pkgs, lib, inputs, stdenv, ... }: {

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
      warp-terminal.overrideAttrs (old: rec {
        pname = "warp-terminal";
        version = "0.2024.04.02.08.02.stable_01";
        src = pkgs.fetchurl {
          url = "https://releases.warp.dev/stable/v${version}/warp-terminal-v${version}-1-x86_64.pkg.tar.zst";
          sha256 = "sha256-xnXRg23AdfCk2TKBr+PZ3wDYqTN4+8wLSodWpmh3D/Y=";
        };
        nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.makeWrapper];
        postInstall = ''
          wrapProgram $out/bin/warp-terminal --set WARP_ENABLE_WAYLAND 1 \
            --prefix LD_LIBRARY_PATH : ${pkgs.wayland}/lib
        '';
      })
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
      skate
      gpg-tui
      git-credential-gopass
      git-credential-keepassxc
      playerctl
      mpc-cli
      procs
      megacmd
      protonmail-bridge
      gimp
      keepassxc
      pavucontrol
      # obsidian
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
