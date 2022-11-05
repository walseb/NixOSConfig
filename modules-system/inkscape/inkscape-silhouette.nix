# { lib
# , python3Packages
# , fetchFromGitHub
# , wrapQtAppsHook
# , cups
# }:

# {
#   nixpkgs.config = {
#     packageOverrides = pkgs: {
#       inkscape-silhouette = (pkgs.inkscape-extensions.inkcut.override {}).overrideAttrs (old: rec {
#         pname = "inkscape-silhouette";
#         version = "master";

#         propagatedBuildInputs = with pkgs.python3Packages; [
#           enamlx
#           twisted
#           lxml
#           qreactor
#           jsonpickle
#           pyserial
#           pycups
#           qtconsole
#           pyqt5
#           libusb1
#         ];

#         src = fetchFromGitHub {
#           owner = "fablabnbg";
#           repo = pname;
#           rev = "0c8942bffdd2d30136bbad41fdb4e50553ce4dec";
#           sha256 = "5Y1h3cfT8vPcm5V70N4QcmVvk9XSajMvFD/y5PKb7eY=";
#         };

#         pythonImportsCheck = [];

#         postInstall = ''
#     mkdir -p $out/share/inkscape/extensions
#     cp -r silhouette $out/share/inkscape/extensions
#     install -m 755 -t $out/share/inkscape/extensions *silhouette*.py
#     install -m 644 -t $out/share/inkscape/extensions *.inx
#   '';

#       });
#     };
#   };
# }


{ lib
, python3Packages
, fetchFromGitHub
, cups
, pkgs
}:

with python3Packages;

buildPythonApplication rec {
  pname = "inkscape-silhouette";
  version = "master";

  src = fetchFromGitHub {
    owner = "fablabnbg";
    repo = pname;
    rev = "0c8942bffdd2d30136bbad41fdb4e50553ce4dec";
    sha256 = "5Y1h3cfT8vPcm5V70N4QcmVvk9XSajMvFD/y5PKb7eY=";
  };

  # postPatch = ''
  #   substituteInPlace inkcut/device/transports/printer/plugin.py \
  #     --replace ", 'lpr', " ", '${cups}/bin/lpr', "
  # '';

  propagatedBuildInputs = [
    enamlx
    twisted
    lxml
    qreactor
    jsonpickle
    pyserial
    pycups
    libusb1
    inkex
    pkgs.libusb
    pkgs.libusb-compat-0_1
    pyusb
  ];

  buildInputs = [
    enamlx
    twisted
    lxml
    qreactor
    jsonpickle
    pyserial
    pycups
    libusb1
    inkex
    pkgs.libusb
    pkgs.libusb-compat-0_1
    pyusb
  ];

  # QtApplication.instance() does not work during tests?
  doCheck = false;

  # pythonImportsCheck = [
  #   "inkcut"
  #   "inkcut.cli"
  #   "inkcut.console"
  #   "inkcut.core"
  #   "inkcut.device"
  #   "inkcut.job"
  #   "inkcut.joystick"
  #   "inkcut.monitor"
  #   "inkcut.preview"
  # ];


  postInstall = ''
      mkdir -p $out/share/inkscape/extensions
      cp -r silhouette $out/share/inkscape/extensions
      install -m 755 -t $out/share/inkscape/extensions *silhouette*.py
      install -m 644 -t $out/share/inkscape/extensions *.inx
    '';
}
