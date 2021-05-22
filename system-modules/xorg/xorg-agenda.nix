{ pkgs, xrandr-output, file, xrandr-extra ? "", ... }:
{

  environment.systemPackages = with pkgs; [
    xorg.xrandr
    inotify-tools
    surf
    xterm
    dwm
  ];

  services.xserver = {
    enable = true;
    layout = "us";

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
        name = "agenda";
        start = ''
            xrandr --output ${xrandr-output} ${xrandr-extra}
            while true; do
                ${pkgs.dwm}/bin/dwm &
                PID=$!
                ${pkgs.surf}/bin/surf ${file} &
                PIDSURF=$!
                ${pkgs.inotify-tools}/bin/inotifywait -e modify ${file}
                # Give transfer some time to complete
                # ${pkgs.coreutils}/bin/sleep 5
                kill $PID
                kill $PIDSURF
            done
          '';
      }
    ];

    #  Set emacs as default entry
    displayManager.defaultSession = "agenda";
  };
}
