{ config, ... }:
{
  services.pueue = {
    enable = true;
    settings = {
      shared = {
        pueue_directory = "${config.home.homeDirectory}/.local/share/pueue";
        use_unix_socket = true;
      };
      client = {
        dark_mode = true;
      };
      daemon = {
        default_parallel_tasks = 2;
      };
    };
  };
}
