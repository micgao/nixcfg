{ lib
, fetchFromGitHub
, rustPlatform
, nixosTests

, cmake
, scdoc
, installShellFiles
, makeWrapper
, ncurses
, pkg-config
, python3

, expat
, fontconfig
, freetype
, libGL
, xorg
, libxkbcommon
, wayland
, xdg-utils
}:

let
  rpathLibs = [
    expat
    fontconfig
    freetype
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libxcb
    libxkbcommon
    wayland
  ];
in
rustPlatform.buildRustPackage rec {
  pname = "alacritty";
  version = "187f9ca3e5c436a59e9c0249c5aa9de77058c05d";

  src = fetchFromGitHub {
    owner = "alacritty";
    repo = pname;
    rev = version;
    hash = "sha256-2LlrH1r2eGA/WZqkol1IaFwVavoPF+PEC5UdUoAIXsE=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  nativeBuildInputs = [
    scdoc
    cmake
    installShellFiles
    makeWrapper
    ncurses
    pkg-config
    python3
  ];

  buildInputs = rpathLibs;

  outputs = [ "out" "terminfo" ];

  postPatch = lib.optionalString (!xdg-utils.meta.broken) ''
    substituteInPlace alacritty/src/config/ui_config.rs \
      --replace xdg-open ${xdg-utils}/bin/xdg-open
  '';

  checkFlags = [ "--skip=term::test::mock_term" ]; # broken on aarch64

  postInstall = (
    ''
      install -D extra/linux/Alacritty.desktop -t $out/share/applications/
      install -D extra/linux/org.alacritty.Alacritty.appdata.xml -t $out/share/appdata/
      install -D extra/logo/compat/alacritty-term.svg $out/share/icons/hicolor/scalable/apps/Alacritty.svg

      $STRIP -S $out/bin/alacritty

      patchelf --add-rpath "${lib.makeLibraryPath rpathLibs}" $out/bin/alacritty
    ''
  ) + ''

    installShellCompletion --zsh extra/completions/_alacritty
    installShellCompletion --bash extra/completions/alacritty.bash
    installShellCompletion --fish extra/completions/alacritty.fish

    install -dm 755 "$out/share/man/man1"
    install -dm 755 "$out/share/man/man5"

    install -dm 755 "$terminfo/share/terminfo/a/"
    tic -xe alacritty,alacritty-direct -o "$terminfo/share/terminfo" extra/alacritty.info
    mkdir -p $out/nix-support
    echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
  '';

  dontPatchELF = true;

  passthru.tests.test = nixosTests.terminal-emulators.alacritty;

  meta = with lib; {
    description = "A cross-platform, GPU-accelerated terminal emulator";
    homepage = "https://github.com/alacritty/alacritty";
    license = licenses.asl20;
    mainProgram = "alacritty";
    maintainers = [];
    platforms = platforms.unix;
  };
}

