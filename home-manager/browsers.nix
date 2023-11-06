{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
  };
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
  };
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
