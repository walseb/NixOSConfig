{ pkgs, ... }:
{
  services.dunst.enable = true;
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
        geometry = "300x5-05+05";

        # transparency = 10;
        # frame_color = "#eceff1";
        # background = "#37474f";
        # foreground = "#eceff1";

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

        # font = "Roboto Mono";
        font = "Px437 IBM VGA 8x16";

        timeout = 5;
      };
      # urgency_normal = {
      #   background = "#37474f";
      #   foreground = "#eceff1";
      #   timeout = 5;
      # };
    };
}
