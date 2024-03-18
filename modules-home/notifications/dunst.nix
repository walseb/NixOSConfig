{ pkg-s, my_font, ... }:
{
  services.dunst.enable = true;
  services.dunst.package = pkg-s.dunst;
  services.dunst.settings =
    {
      global = {
        # geometry [{width}]x{height}][+/-{x}+/-{y}]
        # The geometry of the message window.
        # The height is measured in number of notifications everything else in pixels. If the width
        # is omitted but the height is given ("-geometry x2"), the message window
        # expands over the whole screen (dmenu-like). If width is 0,
        # the window expands to the longest message displayed.
        # A positive x is measured from the left, a negative from the
        # right side of the screen.  Y is measured from the top and down respectevly.
        # The width can be negative. In this case the actual width is the
        # screen width minus the width defined in within the geometry option.
        # geometry = "300x5-30+50";
        # geometry = "300x5-200+200";

        width = 300;
        height = 300;
        offset = "0x21";
        origin = "top-right";

        # transparency = 10;
        # frame_color = "#eceff1";
        background = "#005AA6";
        # foreground = "#eceff1";

        frame_color = "#61A7F2";

        # No border
        frame_width = 0;

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        format = ''%b'';

        word_wrap = true;
        stack_duplicates = true;
        # show_icons = "left";
        # icon_position = "left";
        icon_position = "off";

        font = my_font;
        # font = "Roboto Mono";
        # font = "Px437 IBM VGA 8x16";

        timeout = 5;

        mouse_left_click = "close_current";
        # mouse_middle_click = "do_action";

        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";

        progress_bar = true;

        progress_bar_height = 10;
        progress_bar_frame_width = 1;

        # Set the minimum width for the progress bar
        progress_bar_min_width = 150;

        # Set the maximum width for the progress bar
        progress_bar_max_width = 300;

        transparency = 10;
      };
      urgency_critical = {
        # background = "#af0000";
        # foreground = "#eceff1";
        background = "#1a2d07";
        foreground = "#67b11d";

        timeout = 20;
      };

      # urgency_critical = {
      #   background = "#af0000";
      #   foreground = "#eceff1";
      #   timeout = 20;
      # };

      urgency_low = {
        background = "#1a2d07";
        foreground = "#67b11d";
        timeout = 20;
      };
    };
}