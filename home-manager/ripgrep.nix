{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep.override {
      withPCRE2 = true;
      buildFeatures = [
        "simd-accel"
        "avx-accel"
      ];
    };
    arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
  };
}
