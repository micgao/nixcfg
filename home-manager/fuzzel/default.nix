{ pkgs, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.wezterm}/bin/wezterm";
        layer = "overlay";
        font = "Iosevka Fixed SS04 Extended:size=10";
        show-actions = "yes";
        icon-theme = "Qogir-dark";
        icons-enabled = "yes";
      };
      colors.background = "282a36dd";
      colors.text = "f8f8f2ff";
      colors.match = "8be9fdff";
      colors.selection-match = "8be9fdff";
      colors.selection = "44475add";
      colors.selection-text = "f8f8f2ff";
      colors.border = "bd93f9ff";
    };
  };
}
