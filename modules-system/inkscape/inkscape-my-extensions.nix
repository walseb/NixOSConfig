{ inkscape-silhouette, ... }:

{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      inkscape-my-extensions = (pkgs.inkscape-with-extensions.override {}).overrideAttrs (old: rec {
        inkscapeExtensions = [inkscape-silhouette];
      });
    };
  };
}


  #   { lib
  #   , python3Packages
  #   , fetchFromGitHub
  #   , wrapQtAppsHook
  #   , cups
  #   }:

  # with python3Packages;

  # buildPythonApplication rec {
  #   pname = "inkscape-silhouette";
  #   version = "master";

  #   src = fetchFromGitHub {
  #     owner = pname;
  #     repo = pname;
  #     rev = "0c8942bffdd2d30136bbad41fdb4e50553ce4dec";
  #     sha256 = "0ex0xdv6kyzkkpmvryrdfavv1qy2xrqdxkpmhvx1gj649xcabv32";
  #   };

  #   # postPatch = ''
  #   #   substituteInPlace inkcut/device/transports/printer/plugin.py \
  #   #     --replace ", 'lpr', " ", '${cups}/bin/lpr', "
  #   # '';

  #   nativeBuildInputs = [ wrapQtAppsHook ];

  #   propagatedBuildInputs = [
  #     enamlx
  #     twisted
  #     lxml
  #     qreactor
  #     jsonpickle
  #     pyserial
  #     pycups
  #     qtconsole
  #     pyqt5
  #     pyusb
  #   ];

  #   # QtApplication.instance() does not work during tests?
  #   doCheck = false;

  #   # pythonImportsCheck = [
  #   #   "inkcut"
  #   #   "inkcut.cli"
  #   #   "inkcut.console"
  #   #   "inkcut.core"
  #   #   "inkcut.device"
  #   #   "inkcut.job"
  #   #   "inkcut.joystick"
  #   #   "inkcut.monitor"
  #   #   "inkcut.preview"
  #   # ];

  #   dontWrapQtApps = true;
  #   makeWrapperArgs = [ "\${qtWrapperArgs[@]}" ];

  #   services.udev.extraRules = ''
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="112f", MODE="666", ENV{silhouette_cameo3}="yes", GOTO="end"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="1121", MODE="666", ENV{silhouette_cameo}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="1123", MODE="666", ENV{silhouette_portrait}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="1132", MODE="666", ENV{silhouette_portrait2}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="113a", MODE="666", ENV{silhouette_portrait3}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="111d", MODE="666", ENV{silhouette_sd_2}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="111c", MODE="666", ENV{silhouette_sd_1}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="110a", MODE="666", ENV{craftrobo_cc200_20}="yes"
  # ATTRS{idVendor}=="0b4d", ATTRS{idProduct}=="111a", MODE="666", ENV{craftrobo_cc300_20}="yes"
  # LABEL="end"

  # ENV{silhouette_cameo}=="yes",     RUN="/lib/udev/silhouette-udev-notify.sh", GOTO="very_end"
  # ENV{silhouette_portrait}=="yes",  RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{silhouette_portrait2}=="yes", RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{silhouette_portrait3}=="yes", RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{silhouette_sd_2}=="yes",      RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{silhouette_sd_1}=="yes",      RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{craftrobo_cc200_20}=="yes",   RUN="/lib/udev/silhouette-udev-notify.sh"
  # ENV{craftrobo_cc300_20}=="yes",   RUN="/lib/udev/silhouette-udev-notify.sh"
  # LABEL="very_end"
  #   '';

  #   postInstall = ''
  #     mkdir -p $out/share/inkscape/extensions
  #     cp -r silhouette $out/share/inkscape/extensions
  #     install -m 755 -t $out/share/inkscape/extensions *silhouette*.py
  #     install -m 644 -t $out/share/inkscape/extensions *.inx
  #   '';
  # }
