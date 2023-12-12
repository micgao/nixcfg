{ lib
, buildNpmPackage
, fetchFromGitHub
, remarshal
, ttfautohint-nox
}:

buildNpmPackage rec {
  pname = "iosevka-murpins";
  version = "28.0.0-beta.3";

  src = fetchFromGitHub {
    owner = "be5invis";
    repo = "iosevka";
    rev = "5327eaa9358fc38c106c6577d7c44da8c97867a4";
    hash = "sha256-B7Kzd2IzrUL8Wp/KBbbKRI8sF7NXVrN73n6dpzh9PcA=";
  };

  npmDepsHash = "sha256-ui8IE9fxNoCUm1NPVIgN1DDzQS5lKwYup3Owg7zKPIs=";

  nativeBuildInputs = [
    remarshal
    ttfautohint-nox
  ];

  privateBuildPlan = ./private-build-plans.toml;

  buildPlan = privateBuildPlan;

  passAsFile = [ "buildPlan" ];

  configurePhase = ''
    runHook preConfigure
    runHook postConfigure
  '';

  buildPhase = ''
    export HOME=$TMPDIR
    runHook preBuild
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaPippin
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaMerry
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaHatahata
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaCoco
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaWhiskeyKazumi
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    install "dist/.super-ttc"/* "$fontdir"
    runHook postInstall
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://typeof.net/Iosevka/";
    downloadPage = "https://github.com/be5invis/Iosevka/releases";
    description = "Versatile typeface for code, from code.";
    longDescription = ''
      Iosevka is an open-source, sans-serif + slab-serif, monospace +
      quasi‑proportional typeface family, designed for writing code, using in
      terminals, and preparing technical documents.
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainkrs = with maintainers; [];
  };
}
