{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "feather-wallet";
  src = fetchurl {
    url = "https://featherwallet.org/files/releases/linux-appimage/feather-2.4.9.AppImage";
    sha256 = "ac8c39a6988d0f3cbd023cc17a4561aca972402bbe3605830c0f5069910e3494";
  };
}
