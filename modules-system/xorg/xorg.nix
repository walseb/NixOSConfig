{ pkgs, ... }:
{
  imports = [
    # ./picom.nix
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

    displayManager = {
      sddm.enable = true;
      # gdm.enable = true;

      # Allow exwm to work
      sessionCommands =
        "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";

      # session = [{
      #   manage = "desktop";
      #   name = "st";
      #   # https://lists.suckless.org/hackers/1611/13652.html
      #   start = ''
      #     st -e /bin/bash --login &
      #     waitPID=$!
      #   '';
      # }];

      session =
        [ { manage = "desktop";
            name = "xterm";
            start = ''
            ${pkgs.xterm}/bin/xterm -ls &
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
      defaultSession = "emacs";
    };

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

  };
}
