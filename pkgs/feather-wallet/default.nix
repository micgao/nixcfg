{ pkgs, ... }: pkgs.stdenv.mkDerivation rec {
  pname = "feather-wallet";
  version = "2.5.2";

  src = pkgs.fetchgit {
    url = "https://github.com/feather-wallet/feather";
    rev = version;
    sha256 = "sha256-OSBG2W35GYlViwz5eXokpScrMTtPSaWAgEUNw2urm6w=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
    qt6Packages.wrapQtAppsHook
    zxing
    graphviz-nox
    doxygen
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
    zeromq
  ];
}
