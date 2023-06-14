{ config, ... }: {
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
