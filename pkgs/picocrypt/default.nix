{ lib, buildGoModule, fetchFromGithub, ... }: {
  buildGoModule rec {
    pname = "Picocrypt";
    version = "1.3.3";

    src = fetchFromGithub {
      owner = "HACKERALERT";
      repo = "${pname}";
      rev = "7181801e549e9b45f5a92462b1c9807f6cfc94ed";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    CGO_ENABLED = 1;
    
    vendorHash = null;

    ldflags = [
      "-s -w"
    ];

    nativeBuildInputs = with pkgs; [
      gccgo
    ];

    buildInputs = with pkgs; [
    ];

    meta = with lib; {
      description = "A very small, very simple, yet very secure encryption tool.";
      homepage = "https://github.com/HACKERALERT/Picocrypt";
      license = licenses.gpl3;
      maintainers = with maintainers; [ ];
    };

  };
}
