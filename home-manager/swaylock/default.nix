{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      font = "Inter";
      font-size = 18;
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 10;
      grace = 2;
      show-failed-attempts = true;
      ignore-empty-password = true;
      hide-keyboard-layout = true;
    };
  };
}
