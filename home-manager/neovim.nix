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
    extraPackages = with pkgs; [
      unzip
      gcc
      clang
      gnumake
      cmake
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [
      luarocks
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
