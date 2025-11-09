{ pkgs, inputs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
  };
}
