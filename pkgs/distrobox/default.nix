{ stdenvNoCC, lib, fetchFromGitHub, makeWrapper, wget }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "distrobox";
  version = "1.6.0.1";

  src = fetchFromGitHub {
    owner = "89luca89";
    repo = finalAttrs.pname;
    rev = finalAttrs.version;
    hash = "sha256-UWrXpb20IHcwadPpwbhSjvOP1MBXic5ay+nP+OEVQE4=";
  };

  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    runHook preInstall

    # https://github.com/89luca89/distrobox/issues/408
    substituteInPlace ./distrobox-generate-entry \
      --replace 'icon_default="''${HOME}/.local' "icon_default=\"$out"
    ./install -P $out

    runHook postInstall
  '';

  # https://github.com/89luca89/distrobox/issues/407
  postFixup = ''
    wrapProgram "$out/bin/distrobox-generate-entry" \
      --prefix PATH ":" ${lib.makeBinPath [ wget ]}
  '';

  meta = with lib; {
    description = "Wrapper around podman or docker to create and start containers";
    longDescription = ''
      Use any linux distribution inside your terminal. Enable both backward and
      forward compatibility with software and freedom to use whatever distribution
      you’re more comfortable with
    '';
    homepage = "https://distrobox.privatedns.org/";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [];
  };
})

