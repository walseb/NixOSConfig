{ pkg-s, ...}:
{
  environment.systemPackages = with pkg-s; [
    # Needed for chromium?
    libdrm

    chromium
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "cimiefiiaegbelhefglklhhakcgmhkai" # Plasma integration
    ];
  };

  environment.etc."chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkg-s.plasma-browser-integration}/etc/chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json";
}
