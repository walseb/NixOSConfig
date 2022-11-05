{ pkgs, ... }:
{
  imports = [
    ./picom.nix
  ];

  environment.systemPackages = with pkgs; [
    xorg.setxkbmap
    xorg.xkbcomp

    xorg.xrandr
    autorandr

    st
  ];

  services.xserver = {
    enable = true;
    layout = "us";

    # Allow exwm to work
    displayManager.sessionCommands =
      "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";

    # displayManager.session = [{
    #   manage = "desktop";
    #   name = "st";
    #   # https://lists.suckless.org/hackers/1611/13652.html
    #   start = ''
    #     st -e /bin/bash --login &
    #     waitPID=$!
    #   '';
    # }];

    displayManager.session =
      [ { manage = "desktop";
          name = "xterm";
          start = ''
            ${pkgs.xterm}/bin/xterm -ls &
            waitPID=$!
          '';
        }


      ];

    desktopManager.session = [
      {
        manage = "desktop";
        name = "emacs";
        start = ''
            emacs &
            waitPID=$!
          '';
      }
      # {
      #   manage = "desktop";
      #   name = "emacs-safe";
      #   start = ''
      #       emacs --eval "(setq my/run-safe t)" &
      #       waitPID=$!
      #     '';
      # }
      {
        manage = "desktop";
        name = "emacs-safe";
        start = ''
            emacs &
            waitPID=$!
          '';
      }
    ];

    # {
    #   manage = "desktop";
    #   name = "emacs-docked";
    #   start = ''
    #       emacs --my/docked &
    #       waitPID=$!
    #     '';
    # }

    #  Set emacs as default entry
    displayManager.defaultSession = "emacs";

  };
}
