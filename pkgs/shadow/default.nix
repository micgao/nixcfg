{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "shadow";
  src = fetchurl {
    url = "https://update.shadow.tech/launcher/preprod/linux/ubuntu_18.04/ShadowPCBeta.AppImage";
    sha256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
  };
  extraPkgs = pkgs: with pkgs; [
    xorg.libX11
    libva
    libva1
    libdrm
    vaapiVdpau
  ];
}
