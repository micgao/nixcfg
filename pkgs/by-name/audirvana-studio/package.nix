{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  alsa-lib,
  avahi,
  curl,
  systemdLibs,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "audirvana-studio";
  version = "3.3.4";

  # Versioned file from Audirvana's apt repo. The download page's link always
  # points at the latest release, so it can't be pinned. Run ./update.sh to bump.
  src = fetchurl {
    url = "https://audirvana.com/delivery/linux/apt-repo/pool/non-free/audirvana-studio/audirvana-studio_${finalAttrs.version}_amd64.deb";
    hash = "sha256-TAR6+Qr3wKVXdu7YCz8Sm5g32JmAybm+kOns1j6RVgo=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  # Matches the .deb's Depends. Everything else (icu, taglib, libsmb2, ...)
  # is bundled next to the binary and found by autoPatchelf from $out.
  buildInputs = [
    alsa-lib
    avahi
    curl
    systemdLibs # libudev
    (lib.getLib stdenv.cc.cc) # libstdc++, libgcc_s
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib $out/bin
    cp -a opt/audirvana/studio $out/lib/audirvana-studio

    # NixOS manages the service declaratively (see nixos/audirvana.nix).
    rm $out/lib/audirvana-studio/setAsService.sh
    rm -r $out/lib/audirvana-studio/share/etc

    ln -s $out/lib/audirvana-studio/audirvanaStudio $out/bin/audirvana-studio

    runHook postInstall
  '';

  passthru.updateScript = ./update.sh;

  meta = {
    description = "High-resolution audio player (headless server, controlled with Audirvāna Remote)";
    homepage = "https://audirvana.com";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "audirvana-studio";
  };
})
