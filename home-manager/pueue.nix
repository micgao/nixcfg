{
  services.pueue = {
    enable = true;
    settings = {
      client = {
        dark_mode = true;
      };
      daemon = {
        default_parallel_tasks = 2;
      };
    };
  };
}
