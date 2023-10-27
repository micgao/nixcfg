{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType1 {
  name = "feather-wallet";
  src = fetchurl {
    url = "https://featherwallet.org/files/releases/linux-appimage/feather-2.5.2.AppImage";
    hash = "sha256-P5wg9NE9NC1KcT2JNW0OXKsPxmCZs4+nd2mbzWSRGT0=";
  };
}
