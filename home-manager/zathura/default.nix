{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
  };
  xdg.configFile."zathura/zathurarc".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-macchiato";
    hash = "sha256-cuR2W/Iwd57XZ+rE/ldIhIPZOQcHZNLtQEl2rUpC4Ek=";
  };
}
