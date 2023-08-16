{
  programs.rtx = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      settings = {
        experimental = true;
        always_keep_download = false;
        always_keep_install = false;
      };
      tools = {
        node = "latest";
        go = "latest";
        deno = "latest";
      };
    };
  };
}
