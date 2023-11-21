{ pkgs, inputs, ... }:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
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
}
