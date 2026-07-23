{ pkgs, inputs, config, ... }: {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
  };
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
