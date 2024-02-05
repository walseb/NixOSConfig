# https://jacobneplokh.com/how-to-setup-nextcloud-on-nixos/
{pkg-s, ...}:
{
  services.nextcloud = {
    enable = true;
    hostName = "127.0.0.1";
    autoUpdateApps.enable = true;
    package = pkg-s.nextcloud21;

    # https = true;
    maxUploadSize = "100G";

    config = {
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbtype = "pgsql";

      adminuser = "admin";
      # Just put your password in quotation marks in this file
      # The password can't contain quotation marks
      adminpassFile = "/keys/nextcloud-password";
      # overwriteProtocol = "https";
      extraTrustedDomains = [ ../../nixos-private-config/servers.nix.mainServer ];
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [{
      name = "nextcloud";
      ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
    }];
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
