{ inputs, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      inputs.neovim.overlay
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim.override {
      libvterm-neovim = inputs.nixpkgs-staging.legacyPackages.x86_64-linux.libvterm-neovim;
    };
    extraPackages = with pkgs; [
      gcc
      clang
      gnumake
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
