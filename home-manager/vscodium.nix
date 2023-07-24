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
      "editor.fontFamily" = "Iosevka Term SS04 Extended Symbols";
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "on";
      "diffEditor.codeLens" = true;
      "diffEditor.diffAlgorithm" = "advanced";
      "diffEditor.experimental.useVersion2" = true;
      "vscode-neovim.logLevel" = "none";
      "vscode-neovim.neovimClean" = true;
      "vscode-neovim.useCtrlKeysForInsertMode" = false;
      "vscode-neovim.useCtrlKeysForNormalMode" = false;
      "vscode-neovim.mouseSelectionStartVisualMode" = true;
      "github.gitProtocol" = "ssh";
      "codeium.enableSearch" = true;
      "js/ts.implicitProjectConfig.target" = "ESNext";
      "rust-analyzer.diagnostics.experimental.enable" = true;
      "rust-analyzer.restartServerOnConfigChange" = true;
      "tabnine.receiveBetaChannelUpdates" = true;
    };
  };
}
