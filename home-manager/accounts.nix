{ config, ... }: {
  accounts.email = {
    certificatesFile = "/etc/ssl/certs/ca-certificates.crt";
    maildirBasePath = "${config.home.homeDirectory}/Mail";
    accounts = {
      gmail = {
        name = "Main Gmail";
        primary = true;
        address = "micgao1@gmail.com";
        userName = "micgao1@gmail.com";
        flavor = "gmail.com";
        realName = "Michael G";
        imap = {
          host = "imap.gmail.com";
          port = 993;
        };
        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        folders = {
          inbox = "Inbox";
          sent = "Sent";
          drafts = "Drafts";
          trash = "Bin";
        };
        passwordCommand = "gopass show gmail";
      };
    };
  };
}
