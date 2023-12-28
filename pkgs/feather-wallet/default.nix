{ stdenv, fetchgit, pkgs, ... }: 
let
  tor_version = pkgs.tor.version;
in

stdenv.mkDerivation rec {
  pname = "feather-wallet";
  version = "2.6.1";

  src = fetchgit {
    url = "https://github.com/feather-wallet/feather";
    rev = version;
    hash = "sha256-szMNSqkocf/aVs1aF+TLV1qu0MDHTNDiO4V1j4ySBvQ=";
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
