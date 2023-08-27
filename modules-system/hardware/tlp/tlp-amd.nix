{
  imports = [
    ./tlp.nix
  ];

  services.tlp.settings =
    {
      CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = "1";
      CPU_BOOST_ON_BAT = "0";
      START_CHARGE_THRESH_BAT = "75";
      STOP_CHARGE_THRESH_BAT = "80";
    };
}
