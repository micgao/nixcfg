{ pkgs, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Fixed SS04:size=10";
        show-actions = "yes";
        icon-theme = "Dracula";
        icons-enabled = "yes";
        terminal = "alacritty -e";
      };
    };
  };
}
