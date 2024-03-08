{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell-dataframe = prev.nushell.override {
      buildFeatures = [
	      "dataframe"
      ];
    };
  };
}
