{ stdenv
, lib
, buildNpmPackage
, fetchFromGitHub
, remarshal
, ttfautohint-nox
  # Custom font set options.
  # See https://typeof.net/Iosevka/customizer
  # Can be a raw TOML string, or a Nix attrset.

  # Ex:
  # privateBuildPlan = ''
  #   [buildPlans.iosevka-custom]
  #   family = "Iosevka Custom"
  #   spacing = "normal"
  #   serifs = "sans"
  #
  #   [buildPlans.iosevka-custom.variants.design]
  #   capital-j = "serifless"
  #
  #   [buildPlans.iosevka-custom.variants.italic]
  #   i = "tailed"
  # '';

  # Or:
  # privateBuildPlan = {
  #   family = "Iosevka Custom";
  #   spacing = "normal";
  #   serifs = "sans";
  #
  #   variants = {
  #     design.capital-j = "serifless";
  #     italic.i = "tailed";
  #   };
  # }
, privateBuildPlan ? null
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
  # Custom font set name. Required if any custom settings above.
}:

buildNpmPackage rec {
  pname = "iosevka-murpins";
  version = "28.0.1";

  src = fetchFromGitHub {
    owner = "be5invis";
    repo = "iosevka";
    rev = "v${version}";
    hash = "sha256-ecUmSsMo94lVc9R9Y8GziukGrL6Q+b46/Uv/iLlUy/c=";
  };

  npmDepsHash = "sha256-UgCULIxxLHiS57Ut3zwpZW7hxHmeBUWWcXI2yn/Wxb4=";

  nativeBuildInputs = [
    remarshal
    ttfautohint-nox
  ];

  privateBuildPlan = ''
    [buildPlans.IosevkaPippin]
    family = "Iosevka Pippin"
    spacing = "normal"
    serifs = "sans"
    exportGlyphNames = true
    noLigation = true
    buildTextureFeature = true

    [buildPlans.IosevkaPippin.variants]
    inherits = "ss04"

    [buildPlans.IosevkaPippin.weights.ExtraLight]
    shape = 200
    menu = 200
    css = 200

    [buildPlans.IosevkaPippin.weights.Light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.IosevkaPippin.weights.Regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.IosevkaPippin.weights.Medium]
    shape = 500
    menu = 500
    css = 500

    [buildPlans.IosevkaPippin.weights.SemiBold]
    shape = 600
    menu = 600
    css = 600

    [buildPlans.IosevkaPippin.weights.Bold]
    shape = 700
    menu = 700
    css = 700

    [buildPlans.IosevkaPippin.weights.ExtraBold]
    shape = 800
    menu = 800
    css = 800

    [buildPlans.IosevkaPippin.weights.Heavy]
    shape = 900
    menu = 900
    css = 900

    [buildPlans.IosevkaPippin.widths.Condensed]
    shape = 500
    menu = 3
    css = "condensed"

    [buildPlans.IosevkaPippin.widths.Normal]
    shape = 600
    menu = 5
    css = "normal"

    [buildPlans.IosevkaPippin.widths.UltraCondensed]
    shape = 416
    menu = 1
    css = "ultra-condensed"

    [buildPlans.IosevkaPippin.widths.ExtraCondensed]
    shape = 456
    menu = 2
    css = "extra-condensed"

    [buildPlans.IosevkaPippin.widths.SemiCondensed]
    shape = 548
    menu = 4
    css = "semi-condensed"

    [buildPlans.IosevkaPippin.widths.SemiExtended]
    shape = 658
    menu = 6
    css = "semi-expanded"

    [buildPlans.IosevkaPippin.widths.Extended]
    shape = 720
    menu = 7
    css = "expanded"

    [buildPlans.IosevkaMerry]
    family = "Iosevka Merry"
    spacing = "term"
    serifs = "sans"
    exportGlyphNames = true
    noLigation = true
    buildTextureFeature = true

    [buildPlans.IosevkaMerry.variants]
    inherits = "ss04"

    [buildPlans.IosevkaMerry.weights.ExtraLight]
    shape = 200
    menu = 200
    css = 200

    [buildPlans.IosevkaMerry.weights.Light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.IosevkaMerry.weights.Regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.IosevkaMerry.weights.Medium]
    shape = 500
    menu = 500
    css = 500

    [buildPlans.IosevkaMerry.weights.SemiBold]
    shape = 600
    menu = 600
    css = 600

    [buildPlans.IosevkaMerry.weights.Bold]
    shape = 700
    menu = 700
    css = 700

    [buildPlans.IosevkaMerry.weights.ExtraBold]
    shape = 800
    menu = 800
    css = 800

    [buildPlans.IosevkaMerry.weights.Heavy]
    shape = 900
    menu = 900
    css = 900

    [buildPlans.IosevkaMerry.widths.Condensed]
    shape = 500
    menu = 3
    css = "condensed"

    [buildPlans.IosevkaMerry.widths.Normal]
    shape = 600
    menu = 5
    css = "normal"

    [buildPlans.IosevkaMerry.widths.UltraCondensed]
    shape = 416
    menu = 1
    css = "ultra-condensed"

    [buildPlans.IosevkaMerry.widths.ExtraCondensed]
    shape = 456
    menu = 2
    css = "extra-condensed"

    [buildPlans.IosevkaMerry.widths.SemiCondensed]
    shape = 548
    menu = 4
    css = "semi-condensed"

    [buildPlans.IosevkaMerry.widths.SemiExtended]
    shape = 658
    menu = 6
    css = "semi-expanded"

    [buildPlans.IosevkaMerry.widths.Extended]
    shape = 720
    menu = 7
    css = "expanded"

    [buildPlans.IosevkaHatahata]
    family = "Iosevka Hatahata"
    spacing = "fontconfig-mono"
    serifs = "sans"
    exportGlyphNames = true
    noLigation = true
    buildTextureFeature = true

    [buildPlans.IosevkaHatahata.variants]
    inherits = "ss04"

    [buildPlans.IosevkaHatahata.weights.ExtraLight]
    shape = 200
    menu = 200
    css = 200

    [buildPlans.IosevkaHatahata.weights.Light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.IosevkaHatahata.weights.Regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.IosevkaHatahata.weights.Medium]
    shape = 500
    menu = 500
    css = 500

    [buildPlans.IosevkaHatahata.weights.SemiBold]
    shape = 600
    menu = 600
    css = 600

    [buildPlans.IosevkaHatahata.weights.Bold]
    shape = 700
    menu = 700
    css = 700

    [buildPlans.IosevkaHatahata.weights.ExtraBold]
    shape = 800
    menu = 800
    css = 800

    [buildPlans.IosevkaHatahata.weights.Heavy]
    shape = 900
    menu = 900
    css = 900

    [buildPlans.IosevkaHatahata.widths.Condensed]
    shape = 500
    menu = 3
    css = "condensed"

    [buildPlans.IosevkaHatahata.widths.Normal]
    shape = 600
    menu = 5
    css = "normal"

    [buildPlans.IosevkaHatahata.widths.UltraCondensed]
    shape = 416
    menu = 1
    css = "ultra-condensed"

    [buildPlans.IosevkaHatahata.widths.ExtraCondensed]
    shape = 456
    menu = 2
    css = "extra-condensed"

    [buildPlans.IosevkaHatahata.widths.SemiCondensed]
    shape = 548
    menu = 4
    css = "semi-condensed"

    [buildPlans.IosevkaHatahata.widths.SemiExtended]
    shape = 658
    menu = 6
    css = "semi-expanded"

    [buildPlans.IosevkaHatahata.widths.Extended]
    shape = 720
    menu = 7
    css = "expanded"

    [buildPlans.IosevkaCoco]
    family = "Iosevka Coco"
    spacing = "quasi-proportional"
    serifs = "sans"
    exportGlyphNames = true
    buildTextureFeature = true

    [buildPlans.IosevkaCoco.variants.design]
    capital-i = "serifless"
    capital-j = "serifless"
    capital-k = "straight-serifless"
    capital-m = "flat-bottom-serifless"
    capital-w = "straight-flat-top-serifless"
    a = "double-storey-serifless"
    d = "toothed-serifless"
    e = "flat-crossbar"
    f = "flat-hook-serifless"
    g = "single-storey-serifless"
    i = "serifless"
    j = "flat-hook-serifless"
    k = "straight-serifless"
    l = "serifless"
    r = "compact-serifless"
    t = "flat-hook"
    u = "toothed-serifless"
    w = "straight-flat-top-serifless"
    y = "straight-serifless"
    long-s = "flat-hook-serifless"
    eszet = "longs-s-lig-serifless"
    lower-iota = "flat-tailed"
    lower-lambda = "straight-turn"
    lower-tau = "flat-tailed"
    cyrl-capital-ka = "symmetric-connected-serifless"
    cyrl-ka = "symmetric-connected-serifless"
    cyrl-em = "flat-bottom-serifless"
    cyrl-capital-u = "straight-serifless"
    cyrl-u = "straight-serifless"
    cyrl-ef = "serifless"
    cyrl-yeri = "corner"
    cyrl-yery = "corner"
    at = "fourfold"
    percent = "rings-continuous-slash"
    micro-sign = "toothed-serifless"

    [buildPlans.IosevkaCoco.weights.ExtraLight]
    shape = 200
    menu = 200
    css = 200

    [buildPlans.IosevkaCoco.weights.Light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.IosevkaCoco.weights.Regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.IosevkaCoco.weights.Medium]
    shape = 500
    menu = 500
    css = 500

    [buildPlans.IosevkaCoco.weights.SemiBold]
    shape = 600
    menu = 600
    css = 600

    [buildPlans.IosevkaCoco.weights.Bold]
    shape = 700
    menu = 700
    css = 700

    [buildPlans.IosevkaCoco.weights.ExtraBold]
    shape = 800
    menu = 800
    css = 800

    [buildPlans.IosevkaCoco.weights.Heavy]
    shape = 900
    menu = 900
    css = 900

    [buildPlans.IosevkaCoco.widths.Condensed]
    shape = 500
    menu = 3
    css = "condensed"

    [buildPlans.IosevkaCoco.widths.Normal]
    shape = 600
    menu = 5
    css = "normal"

    [buildPlans.IosevkaCoco.widths.UltraCondensed]
    shape = 416
    menu = 1
    css = "ultra-condensed"

    [buildPlans.IosevkaCoco.widths.ExtraCondensed]
    shape = 456
    menu = 2
    css = "extra-condensed"

    [buildPlans.IosevkaCoco.widths.SemiCondensed]
    shape = 548
    menu = 4
    css = "semi-condensed"

    [buildPlans.IosevkaCoco.widths.SemiExtended]
    shape = 658
    menu = 6
    css = "semi-expanded"

    [buildPlans.IosevkaCoco.widths.Extended]
    shape = 720
    menu = 7
    css = "expanded"

    [buildPlans.IosevkaWhiskeyKazumi]
    family = "Iosevka Whiskey Kazumi"
    spacing = "quasi-proportional"
    serifs = "slab"
    exportGlyphNames = true
    buildTextureFeature = true

    [buildPlans.IosevkaWhiskeyKazumi.variants.design]
    capital-m = "flat-bottom-serifed"
    capital-w = "straight-flat-top-serifed"
    f = "flat-hook-serifed"
    i = "serifed"
    j = "flat-hook-serifed"
    l = "serifed"
    t = "flat-hook"
    w = "straight-flat-top-serifed"
    long-s = "flat-hook-bottom-serifed"
    eszet = "longs-s-lig-bottom-serifed"
    lower-iota = "serifed-flat-tailed"
    lower-tau = "flat-tailed"
    cyrl-em = "flat-bottom-serifed"
    at = "fourfold"
    percent = "rings-continuous-slash"

    [buildPlans.IosevkaWhiskeyKazumi.variants.italic]
    f = "flat-hook-tailed"
    i = "serifed-flat-tailed"
    l = "serifed-flat-tailed"
    w = "straight-flat-top-motion-serifed"
    long-s = "flat-hook-tailed"
    eszet = "longs-s-lig-tailed-serifless"

    [buildPlans.IosevkaWhiskeyKazumi.weights.ExtraLight]
    shape = 200
    menu = 200
    css = 200

    [buildPlans.IosevkaWhiskeyKazumi.weights.Light]
    shape = 300
    menu = 300
    css = 300

    [buildPlans.IosevkaWhiskeyKazumi.weights.Regular]
    shape = 400
    menu = 400
    css = 400

    [buildPlans.IosevkaWhiskeyKazumi.weights.Medium]
    shape = 500
    menu = 500
    css = 500

    [buildPlans.IosevkaWhiskeyKazumi.weights.SemiBold]
    shape = 600
    menu = 600
    css = 600

    [buildPlans.IosevkaWhiskeyKazumi.weights.Bold]
    shape = 700
    menu = 700
    css = 700

    [buildPlans.IosevkaWhiskeyKazumi.weights.ExtraBold]
    shape = 800
    menu = 800
    css = 800

    [buildPlans.IosevkaWhiskeyKazumi.weights.Heavy]
    shape = 900
    menu = 900
    css = 900

    [buildPlans.IosevkaWhiskeyKazumi.widths.Condensed]
    shape = 500
    menu = 3
    css = "condensed"

    [buildPlans.IosevkaWhiskeyKazumi.widths.Normal]
    shape = 600
    menu = 5
    css = "normal"

    [buildPlans.IosevkaWhiskeyKazumi.widths.UltraCondensed]
    shape = 416
    menu = 1
    css = "ultra-condensed"

    [buildPlans.IosevkaWhiskeyKazumi.widths.ExtraCondensed]
    shape = 456
    menu = 2
    css = "extra-condensed"

    [buildPlans.IosevkaWhiskeyKazumi.widths.SemiCondensed]
    shape = 548
    menu = 4
    css = "semi-condensed"

    [buildPlans.IosevkaWhiskeyKazumi.widths.SemiExtended]
    shape = 658
    menu = 6
    css = "semi-expanded"

    [buildPlans.IosevkaWhiskeyKazumi.widths.Extended]
    shape = 720
    menu = 7
    css = "expanded"

    [collectPlans.IosevkaMurpins]
    from = [
      "IosevkaPippin",
      "IosevkaMerry",
      "IosevkaCoco",
      "IosevkaHatahata",
      "IosevkaWhiskeyKazumi"
    ]
  '';

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
    npm run build --no-update-notifier -- --jCmd=$NIX_BUILD_CORES --verbose=9 super-ttc::IosevkaMurpins
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    install "dist/$pname/ttc"/* "$fontdir"
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
    maintainers = with maintainers; [];
  };
}
