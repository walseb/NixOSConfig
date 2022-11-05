{ pkgs, ... }: {
  home.packages = with pkgs; [
    # mail
    isync
    msmtp

    # Notmuch
    mailcap
  ];
}
