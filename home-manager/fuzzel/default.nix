{ pkgs, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.wezterm}/bin/wezterm";
        layer = "overlay";
        font = "Iosevka Fixed SS04:size=14";
        show-actions = "yes";
        icon-theme = "Qogir-dark";
        icons-enabled = "yes";
      };
      colors.background = "131317dd";
      colors.text = "868690ff";
      colors.match = "8eb6f5ff";
      colors.selection-match = "8eb6f5ff";
      colors.selection = "1F1F24dd";
      colors.selection-text = "868690ff";
      colors.border = "ffbb88ff";
    };
  };
}
