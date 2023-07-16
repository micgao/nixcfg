{ inputs, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
  };
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
