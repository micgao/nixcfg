{ lib
, fetchFromGitHub
, ncurses
, pkg-config
, python3
, fontconfig
, installShellFiles
, openssl
, libGL
, libxkbcommon
, xcbutil
, xcbutilimage
, xcbutilkeysyms
, xcbutilwm
, wayland
, zlib
, nixosTests
, runCommand
, vulkan-loader
, rustPlatform
, cairo
, libgit2
, sqlite
, zstd
, stdenv
, xorg
}:

rustPlatform.buildRustPackage rec {
  pname = "wezterm";
  version = "main";

  src = fetchFromGitHub {
    owner = "wez";
    repo = pname;
    rev = version;
    hash = "sha256-B3ZsF9IDrZzB573NcpWHPM+Ss5YjV8LDRLjce8RZJd0=";
    fetchSubmodules = true;
  };

  postPatch = ''
    rm -r wezterm-ssh/tests
  '';

  nativeBuildInputs = [
    installShellFiles
    ncurses
    python3
    pkg-config
  ];

  buildInputs = [
    cairo
    libgit2
    libxkbcommon
    openssl
    sqlite
    vulkan-loader
    zlib
    zstd
    fontconfig
  ] ++ lib.optionals stdenv.isLinux [
    wayland
    xorg.libX11
    xorg.libxcb
    libxkbcommon
    openssl
    xcbutil
    xcbutilimage
    xcbutilkeysyms
    xcbutilwm
  ];

  buildFeatures = [ "distro-defaults" ];

  env = {
    OPENSSL_NO_VENDOR = true;
    ZSTD_SYS_USE_PKG_CONFIG = true;
    NIX_LDFLAGS = lib.optionalString stdenv.isDarwin "-framework System";
  };

  postInstall = ''
    mkdir -p $out/nix-support
    echo "${passthru.terminfo}" >> $out/nix-support/propagated-user-env-packages

    install -Dm644 assets/icon/terminal.png $out/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png
    install -Dm644 assets/wezterm.desktop $out/share/applications/org.wezfurlong.wezterm.desktop
    install -Dm644 assets/wezterm.appdata.xml $out/share/metainfo/org.wezfurlong.wezterm.appdata.xml

    install -Dm644 assets/shell-integration/wezterm.sh -t $out/etc/profile.d
    installShellCompletion --cmd wezterm \
      --bash assets/shell-completion/bash \
      --fish assets/shell-completion/fish \
      --zsh assets/shell-completion/zsh

    install -Dm644 assets/wezterm-nautilus.py -t $out/share/nautilus-python/extensions
  '';

  preFixup = lib.optionalString stdenv.isLinux ''
    patchelf \
      --add-needed "${libGL}/lib/libEGL.so.1" \
      --add-needed "${vulkan-loader}/lib/libvulkan.so.1" \
      $out/bin/wezterm-gui
  '' + lib.optionalString stdenv.isDarwin ''
    mkdir -p "$out/Applications"
    OUT_APP="$out/Applications/WezTerm.app"
    cp -r assets/macos/WezTerm.app "$OUT_APP"
    rm $OUT_APP/*.dylib
    cp -r assets/shell-integration/* "$OUT_APP"
    ln -s $out/bin/{wezterm,wezterm-mux-server,wezterm-gui,strip-ansi-escapes} "$OUT_APP"
  '';

  passthru = {
    tests = {
      all-terminfo = nixosTests.allTerminfo;
      terminal-emulators = nixosTests.terminal-emulators.wezterm;
    };
    terminfo = runCommand "wezterm-terminfo"
      {
        nativeBuildInputs = [ ncurses ];
      } ''
      mkdir -p $out/share/terminfo $out/nix-support
      tic -x -o $out/share/terminfo ${src}/termwiz/data/wezterm.terminfo
    '';
  };

  meta = with lib; {
    description = "A GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";
    homepage = "https://github.com/wez/wezterm";
    license = licenses.mit;
    maintainers = with maintainers; [ me ];
    mainProgram = "wezterm";
  };
}
