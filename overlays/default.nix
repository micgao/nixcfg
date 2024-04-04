{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.overrideAttrs (oldAttrs: {
      cargoBuildFeatures = (oldAttrs.cargoBuildFeatures or [ ]) ++ [
        "dataframe"
        "plugin"
      ];
    });
  };
}
