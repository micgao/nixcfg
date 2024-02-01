{ inputs, ... }: {

  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = {
    slug = "sequoia";
    name = "Sequoia";
    palette = {
      base00 = "#0F1014";
      base01 = "#131317";
      base02 = "#1F1F24";
      base03 = "#43444D";
      base04 = "#575861";
      base05 = "#868690";
      base06 = "#9898A6";
      base07 = "#FDFDFE";
      base08 = "#F58EE0";
      base09 = "#8EB6F5";
      base0A = "#A6EBFC";
      base0B = "#5CC9F5";
      base0C = "#FFD493";
      base0D = "#C58FFF";
      base0E = "#FFBB88";
      base0F = "#ACAFFF";
    };
  };

}
