{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "iosevka-ss04";
  version = "28.0.0-alpha.1";

  src = ./fonts;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp *.ttc $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = " ";
    platforms = platforms.all;
  };
}
