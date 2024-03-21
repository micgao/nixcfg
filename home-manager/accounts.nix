{ pkgs, config, ... }: {
  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/.mail";
    accounts = {
      gmail = {
        neomutt.enable = true;
        mu.enable = true;
        # msmtp.enable = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" "[Gmail]*" ];
        };
        primary = true;
        address = "micgao1@gmail.com";
        userName = "micgao1@gmail.com";
        flavor = "gmail.com";
        realName = "Michael G";
        passwordCommand = "${pkgs.pass}/bin/pass gmail/mbsync/micgao1@gmail.com";
      };
    };
  };
}
