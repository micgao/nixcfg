{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.overrideAttrs (oldAttrs: {
      cargoBuildFeatures = (oldAttrs.cargoBuildFeatures or [ ]) ++ [
      	"extra"
	      "dataframe"
	      "plugin"
      ];
    });
    ripgrep = prev.ripgrep.overrideAttrs (oldAttrs: {
      cargoBuildFeatures = (oldAttrs.cargoBuildFeatures or [ ]) ++ [
        "simd-accel"
        "avx-accel"
      ];
    });
  };
}
