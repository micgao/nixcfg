{ lib
, stdenvNoCC
, fetchurl
, appimageTools
}:

let
pname = "warp-terminal";
version = "0.2024.02.20.08.01.stable_01";

linux = appimageTools.wrapType2 {
  inherit pname version;
  src = fetchurl {
    url = "https://releases.warp.dev/stable/v${version}/Warp-x86_64.AppImage";
    hash = "sha256-541IHjrtUGzZwQh5+q4M27/UF2ZTqhznPX6ieh2nqUQ=";
  };
};


meta = with lib; {
  description = "Rust-based terminal";
  homepage = "https://www.warp.dev";
  license = licenses.unfree;
  sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  maintainers = [];
  platforms = platforms.linux;
};

in

linux
