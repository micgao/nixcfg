{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    extensions = with pkgs; [];
    userSettings = {
      "update.mode" = "none";
      "workbench.colorTheme" = "Catppuccin Mocha";
    };
  };
}
