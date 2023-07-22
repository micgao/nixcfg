{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    extensions = with pkgs; [];
    userSettings = {
      "update.mode" = "none";
      "workbench.colorTheme" = "Sinequanone Noir";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.startupEditor" = "none";
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "on";
      "diffEditor.codeLens" = true;
      "diffEditor.diffAlgorithm" = "advanced";
      "diffEditor.experimental.useVersion2" = true;
      "vscode-neovim.logLevel" = "none";
      "vscode-neovim.mouseSelectionStartVisualMode" = true;
      "vscode-neovim.neovimClean" = true;
    };
  };
}
