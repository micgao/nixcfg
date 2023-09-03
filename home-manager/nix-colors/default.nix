{ nix-colors, ... }:
{
  imports = [
    nix-colors.homeManagerModules.default
  ];
  
  colorScheme = {
    slug = "sequoia";
    name = "Sequoia";
    author = "me";
    colors = {
      base00 = "#0f1014";
      base01 = "#131317";
      base02 = "#575861";
      base03 = "#575861";
      base04 = "#868690";
      base05 = "#868690";
      base06 = "#9898a6";
      base07 = "#9898a6";
      base08 = "#f58ee0";
      base09 = "#f58ee0";
      base0A = "#ffbb88";
      base0B = "#ffbb88";
      base0C = "#8eb6f5";
      base0D = "#8eb6f5";
      base0E = "#c58fff";
      base0F = "#c58fff";
    };
    # colors = {
    #   base00 = "#0F1014";
    #   base01 = "#131317";
    #   base02 = "#686974";
    #   base03 = "#817c9c";
    #   base04 = "#817c9c";
    #   base05 = "#9898A2";
    #   base06 = "#9898A2";
    #   base07 = "#9898A2";
    #   base08 = "#EEF0F9";
    #   base09 = "#5cc9f5";
    #   base0A = "#da68fb";
    #   base0B = "#23ebc0";
    #   base0C = "#FFD493";
    #   base0D = "#9898A2";
    #   base0E = "#5cc9f5";
    #   base0F = "#ACAFFF";
    # };
  };
}
