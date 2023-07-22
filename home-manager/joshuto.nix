{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [
    inputs.joshuto.overlays.default
  ];

  programs.joshuto = {
    enable = true;
    package = pkgs.joshuto;
    settings = {
      xdg_open = true;
      xdg_open_fork = true;
      line_number_style = "relative";
    };
  };
}
