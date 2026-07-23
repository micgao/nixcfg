{ inputs, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      gcc
      clang
      gnumake
      nodejs
      lua-language-server
      luajitPackages.luarocks
      sqlite
      fswatch
      nixd
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
