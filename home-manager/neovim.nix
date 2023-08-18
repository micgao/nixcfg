{ inputs, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      unzip
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
