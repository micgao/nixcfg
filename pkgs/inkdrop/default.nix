{ stdenv, dpkg, glibc, fetchurl, gcc-unwrapped, autoPatchelfHook }:
let
  src = ./inkdrop_5.6.2_amd64.deb;

in stdenv.mkDerivation {
  name = "inkdrop";

  system = "x86_64-linux";

  inherit src;

  nativeBuildInputs = [
    autoPatchelfHook 
    dpkg
  ];

  buildInputs = [
    glibc
    gcc-unwrapped
  ];

  unpackPhase = "true";

  meta = {
    description = "Inkdrop";
    platforms = [ "x86_64-linux" ];
  };
}

