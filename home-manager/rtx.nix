{
  programs.rtx = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      settings = {
        experimental = true;
      };
      tools = {
        node = "latest";
      };
    };
  };
}
