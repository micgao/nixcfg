{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    nushell = prev.nushell.override {
      buildFeatures = [
      	"extra"
	      "dataframe"
      ];
    };
  };
}
