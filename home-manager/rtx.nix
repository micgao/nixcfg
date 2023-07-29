{
  programs.rtx = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      settings = {
        experimental = true;
        log_level = "error";
      };
      tools = {
        node = "latest";
      };
    };
  };
}
