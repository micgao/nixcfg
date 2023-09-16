{ inputs, pkgs, ... }: {
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
      cmake
      marksman
      nil
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [
      luarocks
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
