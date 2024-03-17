{ pkgs, pkg-s, ... }:
{
  imports = [
    ./picom.nix
  ];

  environment.systemPackages = with pkg-s; [
    xorg.setxkbmap
    xorg.xkbcomp

    xorg.xrandr
    autorandr

    st
    
    sddm-chili-theme
  ];


  services.xserver = {
    enable = true;
    layout = "us";

    # deviceSection = ''                                                                            
    # Option "DRI" "3"                                                                            
    # '';
    # Option "TearFree" "true"

    displayManager = {
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "admin";
      # sddm.theme = "chili";

      #   sddm.theme = "${(pkgs.fetchFromGitHub {
      #   owner = "MarianArlt";
      #   repo = "kde-plasma-chili";
      #   rev = "a371123959676f608f01421398f7400a2f01ae06";
      #   sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
      # })}";

      # gdm.enable = true;

      # Allow exwm to work
      sessionCommands =
        "${pkg-s.xorg.xhost}/bin/xhost +SI:localuser:$USER";

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
            ${pkg-s.xterm}/bin/xterm -ls &
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
            # https://github.com/ch11ng/exwm/issues/914
            # emacsclient -r &
            # emacsclient -c &
            emacs --internal-border=0 --border-width=0 &
            waitPID=$!
          '';
        # --xrm='Emacs.useXIM: false' 
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
            emacs --eval "(progn
              (setq my/run-safe t)
              (load-file (concat user-emacs-directory "init.el"))
              (load-file (concat user-emacs-directory "early-init.el")))" --xrm='Emacs.useXIM: false' --internal-border=0 --border-width=0 &
            waitPID=$!
          '';
      }
    ];

  };
}
