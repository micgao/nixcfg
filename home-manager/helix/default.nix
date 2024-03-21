{ inputs
, pkgs
, lib
, ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.hostPlatform.system}.default;
    extraPackages = with pkgs; [
      marksman
      nodePackages.vscode-langservers-extracted
      nodePackages.vscode-css-languageserver-bin
      nil
      lua-language-server
      nixpkgs-fmt
    ];
    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            check = {
              command = "clippy";
            };
          };
        };
        typescript-language-server = with pkgs.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
        };
        nil = {
          command = lib.getExe pkgs.nil;
        };
        vscode-css-language-server = {
          command = "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver";
          args = [ "--stdio" ];
          config = {
            provideFormatter = true;
            css.validate.enable = true;
          };
        };
      };
      language = [
        {
          name = "rust";
          auto-format = false;
        }
        {
          name = "nix";
          formatter = {
            command = lib.getExe pkgs.nixpkgs-fmt;
          };
        }
      ];
    };
    settings = {
      keys.normal = {
        space.space = "file_picker";
      };
      keys.insert = {
        j.j = "normal_mode";
      };
      theme = "base16_transparent";
      editor = {
        shell = [ "nu" "-c" ];
        mouse = false;
        line-number = "relative";
        true-color = true;
        undercurl = true;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          rainbow-option = "dim";
        };
        statusline = {
          left = [ "mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" ];
          center = [ "position-percentage" ];
          right = [ "diagnostics" "selections" "register" "position" "file-encoding" "mode" ];
          mode = {
            normal = " ";
            insert = " ";
            select = " ";
          };
        };
        file-picker = {
          hidden = false;
        };
        auto-format = false;
        bufferline = "always";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
  };
}
