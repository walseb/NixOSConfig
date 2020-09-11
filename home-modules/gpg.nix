# https://github.com/nix-community/home-manager/blob/master/modules/programs/gpg.nix
{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "emacs";

    # Not required anymore
    extraConfig = "allow-emacs-pinentry
                   allow-loopback-pinentry";

    # pinentry-program /run/current-system/sw/bin/pinentry-emacs
    # grabKeyboardAndMouse = false;
  };

  programs.gpg = {
    enable = true;

    settings = {
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";

      cipher-algo = "AES256";
      digest-algo = "SHA512";

      # When true this disables symmetric password caching
      no-symkey-cache = false;
    };
  };
}
