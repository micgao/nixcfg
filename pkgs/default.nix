# Local packages, laid out like nixpkgs' pkgs/by-name:
#
#   pkgs/by-name/<name>/package.nix  ->  pkgs.<name>
#
# Adding a package is just adding a directory; nothing here needs editing.
{ lib, callPackage }:

lib.packagesFromDirectoryRecursive {
  inherit callPackage;
  directory = ./by-name;
}
