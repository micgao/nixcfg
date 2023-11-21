{ pkgs, inputs, self, ... }:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        kidex
        randr
        rink
        shell
        stdin
        symbols
        websearch
      ];
    };
    extraCss = builtins.readFile "${self}/home-manager/anyrun/style.css";
  };
}
