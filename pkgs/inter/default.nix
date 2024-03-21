{ lib
, stdenvNoCC
,
}:
stdenvNoCC.mkDerivation {
  pname = "inter";
  version = "4.0";

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
