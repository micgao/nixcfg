{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.overrideAttrs (finalAttrs: oldAttrs: {
      finalAttrs.buildFeatures = oldAttrs.buildFeatures ++ [
      	"extra"
	      "dataframe"
	      "plugin"
      ];
    });
  };
}
