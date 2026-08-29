{ pkgs, inputs, ... }: {
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
