{ stdenv, dpkg, fetchurl, makeWrapper, lib, autoPatchelfHook, pkgs, makeFontsConf, ... }:

stdenv.mkDerivation rec {
  pname = "inkdrop";
  version = "5.6.2";

  src = fetchurl {
    url = "https://api.inkdrop.app/download/linux/deb";
    hash = "sha256-S68h4FM2+Npz4ihQR06GauMiX3PC1rNLaLq/DdmvL6g=";
  };

  nativeBuildInputs = [ dpkg makeWrapper autoPatchelfHook ];

  buildInputs = with pkgs; [
    stdenv.cc.cc
    glib
    libsecret
    libdrm
    musl
    cups
    dbus
    gtk3
    cairo
    pango
    at-spi2-atk
    nss
    nspr
    alsa-lib
    expat
    libdrm
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXrandr
    xorg.libxcb
    xorg.libX11
    xorg.libXext
    xorg.libxkbfile
    xorg.libXfixes
    libxkbcommon
    mesa
  ];

  sourceRoot = ".";

  unpackPhase = ''\
    ar x $src
    tar --no-same-owner --no-same-permissions -xf data.tar.xz
    chmod 0755 usr/lib/inkdrop/chrome-sandbox
    chmod -s usr/lib/inkdrop/chrome-sandbox
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv usr/* $out/
    runHook postInstall
  '';

  FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ ]; };

  meta = with lib; {
    description = "The note-taking app for Markdown lovers";
    homepage = "https://www.inkdrop.app/";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
