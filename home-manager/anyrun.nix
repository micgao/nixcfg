{ pkgs, inputs, ... }:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
  };
}
