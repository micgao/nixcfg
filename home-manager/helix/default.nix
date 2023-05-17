{ inputs, pkgs, ... }: {
  imports = [
  ];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages."x86_64-linux".helix;
  };
}
