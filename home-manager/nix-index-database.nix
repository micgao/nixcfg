{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];
  programs = {
    nix-index.enable = true;
    nix-index.symlinkToCacheHome = true;
    nix-index-database.comma.enable = true;
  };
}
