{ pkgs, inputs, ... }:
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
        shell
        stdin
      ];
    };
    extraCss = builtins.readFile ./style.css;
  };
}
