{ pkgs, ... }: pkgs.appimageTools.wrapType2 {
  name = "feather-wallet";
  src = ./feather-2.5.2;
}
