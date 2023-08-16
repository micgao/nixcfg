{ pkgs, lib, ... }: 
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs.overrideAttrs(old: {
      libPath = lib.makeLibraryPath [pkgs.libglvnd];
    });
    mutableExtensionsDir = true;
    extensions = with pkgs; [
      vscode-extensions.mkhl.direnv
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.github.copilot
      vscode-extensions.github.copilot-chat
      vscode-extensions.genieai.chatgpt-vscode
      vscode-extensions.rust-lang.rust-analyzer
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.tabnine.tabnine-vscode
      vscode-extensions.vadimcn.vscode-lldb
    ];
    userSettings = {
      "update.mode" = "none";
      "workbench.colorTheme" = "Sinequanone Noir";
      "workbench.startupEditor" = "none";
      "editor.fontFamily" = "Iosevka Fixed SS04 Extended";
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "on";
      "diffEditor.codeLens" = true;
      "diffEditor.diffAlgorithm" = "advanced";
      "diffEditor.experimental.useVersion2" = true;
      "vscode-neovim.logLevel" = "none";
      "vscode-neovim.neovimClean" = true;
      "vscode-neovim.useCtrlKeysForInsertMode" = false;
      "vscode-neovim.useCtrlKeysForNormalMode" = false;
      "rust-analyzer.diagnostics.experimental.enable" = true;
      "rust-analyzer.restartServerOnConfigChange" = true;
      "tabnine.experimentalAutoImports" = true;
      "tabnine.receiveBetaChannelUpdates" = true;
    };
  };
}
