{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    ydotool
  ];

  # Find actkbd codes using sudo actkbd -n -s
  # Find ydotool codes at https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
  services.actkbd = {
    enable = true;
    bindings = [
      # Number row
      { keys = [ 30 56 ]; events = [ "key" ]; command = "ydotool key 2"; }
      { keys = [ 31 56 ]; events = [ "key" ]; command = "ydotool key 3"; }
      { keys = [ 32 56 ]; events = [ "key" ]; command = "ydotool key 4"; }
      { keys = [ 33 56 ]; events = [ "key" ]; command = "ydotool key 5"; }
      { keys = [ 34 56 ]; events = [ "key" ]; command = "ydotool key 6"; }
      { keys = [ 35 56 ]; events = [ "key" ]; command = "ydotool key 7"; }
      { keys = [ 36 56 ]; events = [ "key" ]; command = "ydotool key 8"; }
      { keys = [ 37 56 ]; events = [ "key" ]; command = "ydotool key 9"; }
      { keys = [ 38 56 ]; events = [ "key" ]; command = "ydotool key 10"; }
      { keys = [ 39 56 ]; events = [ "key" ]; command = "ydotool key 11"; }

      # Symbol row
      { keys = [ 16 56 ]; events = [ "key" ]; command = "ydotool key 42:1 2:1 2:0 42:0"; }
      { keys = [ 17 56 ]; events = [ "key" ]; command = "ydotool key 42:1 3:1 3:0 42:0"; }
      { keys = [ 18 56 ]; events = [ "key" ]; command = "ydotool key 42:1 4:1 4:0 42:0"; }
      { keys = [ 19 56 ]; events = [ "key" ]; command = "ydotool key 42:1 5:1 5:0 42:0"; }
      { keys = [ 20 56 ]; events = [ "key" ]; command = "ydotool key 42:1 6:1 6:0 42:0"; }
      { keys = [ 21 56 ]; events = [ "key" ]; command = "ydotool key 42:1 7:1 7:0 42:0"; }
      { keys = [ 22 56 ]; events = [ "key" ]; command = "ydotool key 42:1 8:1 8:0 42:0"; }
      { keys = [ 23 56 ]; events = [ "key" ]; command = "ydotool key 42:1 9:1 9:0 42:0"; }
      { keys = [ 24 56 ]; events = [ "key" ]; command = "ydotool key 42:1 10:1 10:0 42:0"; }
      { keys = [ 25 56 ]; events = [ "key" ]; command = "ydotool key 42:1 11:1 11:0 42:0"; }
    ];
  };
}
