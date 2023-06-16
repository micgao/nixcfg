{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
  };
  xdg.configFile."zathura/zathurarc".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
    hash = "sha256-/HXecio3My2eXTpY7JoYiN9mnXsps4PAThDPs4OCsAk=";
  };
}
