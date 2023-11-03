{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty_git;
  };
  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
}
