{ inputs, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      inputs.neovim.overlays.default
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim;
    extraPackages = with pkgs; [
      gcc
      clang
      gnumake
      nodejs
      lua-language-server
      luajitPackages.luarocks
      sqlite
      fswatch
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
