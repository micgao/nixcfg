{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  };
  # programs.librewolf = {
  #   enable = true;
  # };
  # programs.chromium = {
  #   enable = true;
  #   package = pkgs.ungoogled-chromium.override {
  #     enableWideVine = true;
  #   };
  # };
}
