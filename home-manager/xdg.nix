{ config, ... }:
{
  xdg = {
    enable = true;
    configHome = config.home.homeDirectory + "/.config";
    cacheHome = config.home.homeDirectory + "/.local/cache";
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
