{ pkgs, fetchurl, ... }: pkgs.appimageTools.wrapType2 {
  name = "picocrypt";
  src = fetchurl {
    url = "https://github.com/HACKERALERT/Picocrypt/releases/download/1.32/Picocrypt.AppImage";
    sha256 = "c5ac716ee5db70df1baea047877fea732ab58d61e61f1019ec57ae68514fd3de";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
