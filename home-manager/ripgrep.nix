{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep.override { withPCRE2 = true; };
    arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
  };
}
