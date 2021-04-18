{ pkgs, xrandr-output, file, xrandr-extra ? "", ... }:
let
  surfDisplayConf = ''
    # Surf Kiosk Display: Wrap around surf browser and turn your
    # system into a browser screen in KIOSK-mode.
    # default download URI for all display screens if not configured individually
    DEFAULT_WWW_URI="file://${file}"
    # Enforce fixed resolution for all displays (default: not set):
    #DEFAULT_RESOLUTION="1920x1080"
    # Setting for internal inactivity timer to restart surf-display
    # if the user goes inactive/idle.
    INACTIVITY_INTERVAL="0"
    # Launch pulseaudio daemon if not already running.
    WITH_PULSEAUDIO="no"
    # Hide idle mouse pointer.
    HIDE_IDLE_POINTER="yes"

'';
in
{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
    inotify-tools
    surf
    xterm
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

    environment.etc."default/surf-display".text = surfDisplayConf;

    desktopManager.session = [
      {
        manage = "desktop";
        name = "agenda";
        start = ''
            xrandr --output ${xrandr-output} ${xrandr-extra}
            ${pkgs.xterm}/bin/xterm -ls &
            ENDPID=$!
            while true; do
                ${pkgs.surf-display}/bin/surf-display ${file} &
                PID=$!
                ${pkgs.inotify-tools}/bin/inotifywait -e modify ${file}
                kill $PID
            done
            waitPID=ENDPID
          '';
      }
    ];

    #  Set emacs as default entry
    displayManager.defaultSession = "agenda";
  };
}
