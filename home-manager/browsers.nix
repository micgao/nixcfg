{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
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
