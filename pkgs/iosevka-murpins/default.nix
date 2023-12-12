{ lib
, buildNpmPackage
, fetchFromGitHub
, remarshal
, ttfautohint-nox
  # Extra parameters. Can be used for ligature mapping.
  # It must be a raw TOML string.

  # Ex:
  # extraParameters = ''
  #   [[iosevka.compLig]]
  #   unicode = 57808 # 0xe1d0
  #   featureTag = 'XHS0'
  #   sequence = "+>"
  # '';
, extraParameters ? null
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

  buildPlan =
    if builtins.isAttrs privateBuildPlan then
      builtins.toJSON { buildPlans.${pname} = privateBuildPlan; }
    else
      privateBuildPlan;

  inherit extraParameters;
  passAsFile = [ "extraParameters" ] ++ lib.optionals
    (
      !(builtins.isString privateBuildPlan
        && lib.hasPrefix builtins.storeDir privateBuildPlan)
    ) [ "buildPlan" ];

  configurePhase = ''
    runHook preConfigure
    ${lib.optionalString (builtins.isAttrs privateBuildPlan) ''
      remarshal -i "$buildPlanPath" -o private-build-plans.toml -if json -of toml
    ''}
    ${lib.optionalString (builtins.isString privateBuildPlan
      && (!lib.hasPrefix builtins.storeDir privateBuildPlan)) ''
        cp "$buildPlanPath" private-build-plans.toml
      ''}
    ${lib.optionalString (builtins.isString privateBuildPlan
      && (lib.hasPrefix builtins.storeDir privateBuildPlan)) ''
        cp "$buildPlan" private-build-plans.toml
      ''}
    ${lib.optionalString (extraParameters != null) ''
      echo -e "\n" >> params/parameters.toml
      cat "$extraParametersPath" >> params/parameters.toml
    ''}
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
