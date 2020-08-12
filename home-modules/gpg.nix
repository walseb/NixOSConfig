{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "emacs";
    # Not required anymore
    # extraConfig = "allow-emacs-pinentry";

    # pinentry-program /run/current-system/sw/bin/pinentry-emacs
    # grabKeyboardAndMouse = false;
  };
}
