{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.nix-your-shell.overlays.default
  ];
  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = true;
  };
}
