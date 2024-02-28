{ stdenv, fetchgit, pkgs, ... }: 
let
  tor_version = pkgs.tor.version;
in

stdenv.mkDerivation rec {
  pname = "feather-wallet";
  version = "2.6.3";

  src = fetchgit {
    url = "https://github.com/feather-wallet/feather";
    rev = version;
    hash = "sha256-pQnaJbKznK1i8wn7t8ZnxLVu1LV/D47krxZZ0j6Mw6g=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
    qt6Packages.wrapQtAppsHook
    graphviz-nox
    doxygen
  ];

  cmakeFlags = [
    "-DDONATE_BEG=OFF"
    "-DTOR_DIR=${pkgs.tor}/bin"
    "-DTOR_VERSION=${tor_version}"
  ];

  buildInputs = with pkgs; [
    cmake
    openssl
    bc-ur

    unbound
    boost
    expat
    gnupg
    hidapi

    qt6Packages.qtbase
    qt6Packages.qtsvg
    qt6Packages.qtwebsockets
    qt6Packages.qtmultimedia
    qt6Packages.qtwayland

    libgcrypt
    libsodium
    libudev0-shim
    libunwind
    libusb1
    libzip
    hidapi

    protobuf
    qrencode
    zbar
    zxing-cpp
    zeromq
  ];
}
