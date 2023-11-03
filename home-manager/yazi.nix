{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.yazi.overlays.default
  ];
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    package = pkgs.yazi;
  };
}
