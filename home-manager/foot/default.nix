{ config, ... }: 
let
  inherit (config.colorscheme) palette;
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "foot";
        login-shell = "yes";
        font = "Iosevka SS04 Extended:size=11";
        bold-text-in-bright = "yes";
        dpi-aware = "yes";
      };
      cursor = {
        style = "beam";
        beam-thickness = "2";
        blink = "no";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      scrollback = {
        lines = 9001;
      };
      colors = {
        alpha = "1.0";
        background = "${palette.base00}";
        foreground = "${palette.base06}";
        regular0 = "${palette.base00}";
        regular1 = "${palette.base01}";
        regular2 = "${palette.base02}";
        regular3 = "${palette.base03}";
        regular4 = "${palette.base04}";
        regular5 = "${palette.base05}";
        regular6 = "${palette.base06}";
        regular7 = "${palette.base07}";
        bright0 = "${palette.base08}";
        bright1 = "${palette.base09}";
        bright2 = "${palette.base0A}";
        bright3 = "${palette.base0B}";
        bright4 = "${palette.base0C}";
        bright5 = "${palette.base0D}";
        bright6 = "${palette.base0E}";
        bright7 = "${palette.base0F}";
      };
    };
  };
}
