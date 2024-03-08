{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.overrideAttrs (finalAttrs: oldAttrs: {
      buildFeatures = [
      	"extra"
	      "dataframe"
	      "plugin"
      ];
    });
  };
}
