{ inputs, pkgs, ... }:
let
  nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers-deps = pkgs.symlinkJoin {
    name = "treesitter-parsers-deps";
    paths = nvim-treesitter.dependencies;
  };
in
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
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    ];
    extraPackages = with pkgs; [
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
  xdg.configFile = {
    "nvim/lua/init.lua".text = ''
      vim.opt.runtimepath:append("${nvim-treesitter}")
      vim.opt.runtimepath:append("${treesitter-parsers-deps}")
      require("config.options")
      require("config.lazy")
      require("config.autocmds")
      require("config.keymap")
    '';
  };
}
