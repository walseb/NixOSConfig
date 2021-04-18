{ pkgs, xrandr-output, agenda-dir, xrandr-extra ? "", ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
    inotify-tools
    surf
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
            xrandr --output ${xrandr-output} --rotate right ${xrandr-extra}
            while true; do
                surf ${agenda-dir} &
                PID=$!
                inotifywait -e modify ${agenda-dir}
                kill $PID
            done
          '';
      }
    ];

    #  Set emacs as default entry
    displayManager.defaultSession = "agenda";
  };
}
