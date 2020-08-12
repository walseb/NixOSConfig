{ pkgs, ... }:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

  accounts.email = {
    accounts.main-gmail = {
      primary = true;

      userName = "s.walinder@gmail.com";
      address = "s.walinder@gmail.com";

      imap.host = "imap.gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      realName = "Sebastian Wålinder";

      # Encrypted email
      # gpg = {
      #   key = "";
      #   signByDefault = true;
      # };

      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
        tls.useStartTls = true;
      };

      msmtp.enable = true;
    };
  };
}
