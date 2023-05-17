{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "feather-wallet";
  src = fetchurl {
    url = "https://featherwallet.org/files/releases/linux-appimage/feather-2.4.5.AppImage";
    sha256 = "04abfae1986ea21250a9110b0d36b9e064c65d0da360e4bee997fdea85b9481a";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
