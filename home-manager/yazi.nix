{ pkgs, inputs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    shellWrapperName = "y";
  };
}
