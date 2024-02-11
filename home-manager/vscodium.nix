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
      vscode-extensions.github.copilot
      vscode-extensions.github.copilot-chat
      vscode-extensions.rust-lang.rust-analyzer
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.tabnine.tabnine-vscode
      vscode-extensions.vadimcn.vscode-lldb
    ];
  };
}
