{ additionalFeatures ? (p: p) }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.overrideAttrs (oldAttrs: {
      buildFeatures = additionalFeatures [
	      "dataframe"
      ];
    });
  };
}
