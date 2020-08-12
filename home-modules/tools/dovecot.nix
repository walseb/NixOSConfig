{ pkgs, ... }:
{
  dovecot2.enable = true;
  dovecot2.configFile = "/etc/nixos/dovecot.conf";
  # TODO when fixing this. The password files are all read/write only to user admin, this would have to change if dovecot got to use its own user.
  dovecot2.user = "admin";
  dovecot2.group = "users";
}
