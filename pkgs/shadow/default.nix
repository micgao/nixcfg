{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "shadow";
  src = fetchurl {
    url = "https://update.shadow.tech/launcher/preprod/linux/ubuntu_18.04/ShadowPCBeta.AppImage";
    sha256 = "6161A8587298913AD4C9C7BCE70BFB8DC2556CD73A6004D8F6BB8D8BE3311028";
  };
  extraPkgs = pkgs: with pkgs; [
    xorg.libX11
    libva
    libva1
    libdrm
    vaapiVdpau
  ];
}
