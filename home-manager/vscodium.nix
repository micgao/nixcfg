{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    extensions = with pkgs; [
      vscode-extensions.mkhl.direnv
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.rust-lang.rust-analyzer
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.vadimcn.vscode-lldb
    ];
    userSettings = {
      "update.mode" = "none";
      "workbench.colorTheme" = "Sinequanone Noir";
      "workbench.startupEditor" = "none";
      "workbench.activityBar.location" = "hidden";
      "window.titleBarStyle" = "custom";
      "editor.fontFamily" = "Iosevka SS04";
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "on";
      "diffEditor.codeLens" = true;
      "diffEditor.diffAlgorithm" = "advanced";
      "vscode-neovim.logLevel" = "none";
      "vscode-neovim.neovimClean" = true;
      "rust-analyzer.diagnostics.experimental.enable" = true;
      "rust-analyzer.restartServerOnConfigChange" = true;
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    };
  };
}
