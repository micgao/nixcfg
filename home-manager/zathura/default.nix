{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
  };
  xdg.configFile."zathura/zathurarc".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dracula/zathura/master/zathurarc";
    hash = "sha256-7qNQK104EW1/heux+DW3dUdfRcKdiUQEp+ktiVw60G4=";
  };
}
