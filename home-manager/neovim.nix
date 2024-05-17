{ inputs, pkgs, ... }:
{
  nixpkgs = {
    # overlays = [
    #   inputs.neovim.overlay
    # ];
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
      sqlite
      fswatch
    ];
    extraLuaPackages = ps: with ps; [
      luajitPackages.luarocks
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
