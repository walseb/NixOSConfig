{ pkgs, xrandr-output, file, xrandr-extra ? "", ... }: {

  environment.systemPackages = with pkgs; [
    xorg.xrandr
    inotify-tools
    # surf
    # (pkgs.surf.override { patches = ../../loose-configs/surf/autoplay.patch; })

    chromium

    xterm
    dwm

    # These don't expose their paths
    # gst_all_1.gst-plugins-bad
    # gst_all_1.gst-plugins-base
    # gst_all_1.gst-plugins-good
  ];

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.session = [{
      manage = "desktop";
      name = "xterm";
      start = ''
        ${pkgs.xterm}/bin/xterm -ls &
        waitPID=$!
      '';
    }];

    desktopManager.session = [{
      manage = "desktop";
      name = "agenda";
      start = ''
        xrandr --output ${xrandr-output} ${xrandr-extra}
        while true; do
            ${pkgs.dwm}/bin/dwm &
            PID=$!
            ${pkgs.chromium}/bin/chromium ${file} --autoplay-policy=no-user-gesture-required --mute-audio &
            PIDBROWSER=$!
            ${pkgs.inotify-tools}/bin/inotifywait -e modify ${file}
            # Give transfer some time to complete
            # ${pkgs.coreutils}/bin/sleep 5
            kill $PID
            kill $PIDBROWSER
        done
      '';
    }];

    #  Set emacs as default entry
    displayManager.defaultSession = "agenda";
  };
}