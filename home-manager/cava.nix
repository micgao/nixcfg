{
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 144;
      output = {
        channels = "mono";
        mono_option = "average";
        disable_blanking = 1;
      };
      smoothing = {
        monstercat = 1;
        waves = 1;
      };
    };
  };
}
