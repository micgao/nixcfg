{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
  };
  xdg.configFile."zathura/zathurarc".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
    hash = "sha384-EK37b/iN3rKVZ5XigdicSCS/2woYiMeg7vx7rSed8on2RxkldoWi5iCPGUEdhql+";
  };
}
