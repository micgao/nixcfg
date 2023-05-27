{ inputs, pkgs, ... }: {
  imports = [
  ];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.hostPlatform.system}.default;
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
        statusline.center = ["position-percentage"];
      };
    };
  };
}
