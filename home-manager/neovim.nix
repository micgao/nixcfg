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
    package = pkgs.neovim;
    extraPackages = with pkgs; [
      gcc
      clang
      gnumake
      nodejs
      lua-language-server
      codeium
      luajitPackages.luarocks
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
