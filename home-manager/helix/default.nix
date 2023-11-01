{ inputs, pkgs, ... }: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.hostPlatform.system}.default;
    languages = {
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      };
      language = [{
        name = "rust";
        auto-format = false;
      }];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        shell = ["nu" "-c"];
        mouse = false;
        line-number = "relative";
        true-color = true;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
        statusline.center = ["position-percentage"];
        file-picker = {
          hidden = false;
        };
        auto-format = false;
        bufferline = "always";
      };
    };
  };
}
