{
  imports = [
    ./tlp.nix
  ];

  services.tlp.settings = {
    # https://linrunner.de/tlp/settings/processor.html
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_HWP_ON_AC = "performance";
    CPU_HWP_ON_BAT = "power";
    CPU_HWP_DYN_BOOST_ON_AC = "1";
    CPU_HWP_DYN_BOOST_ON_BAT = "0";

    CPU_MIN_PERF_ON_AC = "0";
    CPU_MAX_PERF_ON_AC = "100";
    CPU_MIN_PERF_ON_BAT = "0";
    CPU_MAX_PERF_ON_BAT = "30";

    SCHED_POWERSAVE_ON_AC = "0";
    SCHED_POWERSAVE_ON_BAT = "1";

    ENERGY_PERF_POLICY_ON_AC = "performance";
    ENERGY_PERF_POLICY_ON_BAT = "power";

    CPU_BOOST_ON_AC = "1";
    CPU_BOOST_ON_BAT = "0";

    START_CHARGE_THRESH_BAT = "75";
    STOP_CHARGE_THRESH_BAT = "80";

    START_CHARGE_THRESH_BAT0 = "75";
    STOP_CHARGE_THRESH_BAT0 = "80";

    START_CHARGE_THRESH_BAT1="75";
    STOP_CHARGE_THRESH_BAT1="80";

    NATACPI_ENABLE="1";
    TPACPI_ENABLE="1";
    TPSMAPI_ENABLE="1";
  };
}
