{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "monaspace";
  version = "1.0.0";

  src = ./fonts;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = " ";
    platforms = platforms.all;
  };
}
