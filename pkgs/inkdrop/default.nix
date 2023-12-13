{ stdenv, dpkg, glibc, fetchurl, gcc-unwrapped, autoPatchelfHook }:
let

  src = fetchurl {
    url = "https://api.inkdrop.app/download/linux/deb";
    hash = "sha256-85c6d5eca7799c929bf81fa545ae49d42d027360fddd68746513508e0c1c4f3e";
  };

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

  meta = with stdenv.lib; {
    description = "Inkdrop";
    license = licenses.proprietary;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}

