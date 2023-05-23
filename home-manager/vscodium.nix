{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
  };
}
