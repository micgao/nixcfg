{ stdenv, dpkg, fetchurl, makeWrapper, lib, ... }:

stdenv.mkDerivation rec {
  pname = "inkdrop";
  version = "5.6.2";

  src = fetchurl {
    url = "https://api.inkdrop.app/download/linux/deb";
    hash = "sha256-S68h4FM2+Npz4ihQR06GauMiX3PC1rNLaLq/DdmvL6g=";
  };

  nativeBuildInputs = [ dpkg makeWrapper ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    mv usr/* $out/

    wrapProgram $out/bin/inkdrop \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ stdenv.cc.cc ]}"
  '';
  #
  # preFixup = let
  #   libPath = lib.makeLibraryPath [];
  # in ''
  #   patchelf \
  #     --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
  #     --set-rpath "${libPath}" \
  #     $out/bin/inkdrop
  # '';

  meta = with lib; {
    description = "The note-taking app for Markdown lovers";
    homepage = "https://www.inkdrop.app/";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
