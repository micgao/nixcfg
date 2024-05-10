{ pkgs, inputs, ... }: {

  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.hostPlatform.system}.nix-ld-rs;
    libraries = with pkgs; [
      stdenv.cc.cc
      fuse
      fuse3
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk2
      gtk3
      libGL
      libappindicator-gtk2
      libappindicator-gtk3
      libdrm
      libnotify
      libpulseaudio
      libuuid
      libusb1
      xorg.libxcb
      libxkbcommon
      mesa
      nspr
      nss
      pango
      pipewire
      systemd
      icu
      openssl
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxkbfile
      xorg.libxshmfence
      zlib
      SDL
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf
      SDL_image
      SDL_mixer
      SDL_ttf
    ];
  };
}
