{ pkgs,  ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    profiles = {
      default = {
        extensions = with pkgs; [
          vscode-extensions.mkhl.direnv
          vscode-extensions.asvetliakov.vscode-neovim
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
          "vscode-neovim.neovimClean" = true;
          "extensions.experimental.affinity" = {
            "asvetliakov.vscode-neovim" = 1;
          };
        };
      };
    };
  };
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    installRemoteServer = true;
  };
}
