{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
  };
}
