{ pkgs, inputs, config, ... }: {
  imports  = [
    inputs.helium.homeModules.default
  ];
  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };
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
