{ config, ... }: {
  accounts.email = {
    certificatesFile = "/etc/ssl/certs/ca-certificates.crt";
    maildirBasePath = "${config.home.homeDirectory}/Mail";
    accounts = {
      gmail = {
        primary = false;
        address = "micgao1@gmail.com";
        flavor = "gmail.com";
        realName = "Michael G";
      };
      proton = {
        primary = true;
        address = "micgao@pm.me";
        realName = "Michael G";
      };
    };
  };
}
