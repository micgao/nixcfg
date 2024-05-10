{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  };
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
  };
}
