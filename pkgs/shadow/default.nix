{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "shadow";
  src = fetchurl {
    url = "https://update.shadow.tech/launcher/preprod/linux/ubuntu_18.04/ShadowPCBeta.AppImage";
    sha256 = "87890ef14401d39c39e15b360e7a4755d78b09100c99da600db5297c974a5b72";
  };
  extraPkgs = pkgs: with pkgs; [
    xorg.libX11
    libva1
    libdrm
  ];
}
