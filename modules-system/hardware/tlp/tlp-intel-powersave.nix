{
  imports = [
    ./tlp.nix
  ];

  services.tlp.settings = {
    # https://linrunner.de/tlp/settings/processor.html
    CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC = "power";
    CPU_HWP_ON_AC = "power";
    CPU_HWP_DYN_BOOST_ON_AC = "1";

    CPU_MIN_PERF_ON_AC = "0";
    CPU_MAX_PERF_ON_AC = "100";

    SCHED_POWERSAVE_ON_AC = "1";

    ENERGY_PERF_POLICY_ON_AC = "power";

    CPU_BOOST_ON_AC = "1";

    NATACPI_ENABLE="1";
    TPACPI_ENABLE="1";
    TPSMAPI_ENABLE="1";
  };
}
