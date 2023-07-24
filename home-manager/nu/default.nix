{
  programs.nushell = {
    enable = true;
    configfile.source = ./config.nu;
    envfile.source = ./env.nu;
  };
}
